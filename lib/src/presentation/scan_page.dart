import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/history_controller.dart';
import '../domain/scan_result.dart';
import '../infrastructure/wifi_connect_service.dart';
import 'app_chrome.dart';
import 'language_menu_button.dart';
import 'localization_helpers.dart';
import 'rate_app_action.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  final _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );
  final _wifiService = WifiConnectService();
  ScanResult? _result;
  bool _handlingDetection = false;
  bool _torchOn = false;
  bool _scanningImage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.scan),
        actions: [
          const LanguageMenuButton(),
          const RateAppAction(),
          IconButton(
            tooltip: context.l10n.flash,
            onPressed: _toggleTorch,
            icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off),
          ),
          IconButton(
            tooltip: context.l10n.scanImage,
            onPressed: _scanningImage ? null : _scanFromGallery,
            icon: _scanningImage
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.photo_library_outlined),
          ),
        ],
      ),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        MobileScanner(
                          controller: _controller,
                          onDetect: _onDetect,
                        ),
                        const _ScannerScrim(),
                        const _ScannerFrame(),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: _ScanResultPanel(
                    result: _result,
                    onOpen: _openResult,
                    onCopy: _copyResult,
                    onResume: _resumeScanning,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handlingDetection || capture.barcodes.isEmpty) return;
    final rawValue = capture.barcodes.first.rawValue;
    if (rawValue == null || rawValue.trim().isEmpty) return;
    _handlingDetection = true;
    await _controller.stop();
    _setResult(rawValue);
  }

  Future<void> _scanFromGallery() async {
    final l10n = context.l10n;
    setState(() => _scanningImage = true);
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        _showMessage(l10n.imageSelectionCancelled);
        return;
      }
      _showMessage(l10n.scanningSelectedImage);
      final capture = await _controller.analyzeImage(image.path);
      final qrBarcode = capture?.barcodes
          .where((barcode) => barcode.format == BarcodeFormat.qrCode)
          .firstOrNull;
      final rawValue = qrBarcode?.rawValue?.trim();
      if (rawValue == null || rawValue.isEmpty) {
        _showMessage(l10n.noQrFound);
        return;
      }
      await _controller.stop();
      _handlingDetection = true;
      _setResult(rawValue);
      _showMessage(l10n.qrFoundInImage);
    } on PlatformException catch (error) {
      _showMessage(l10n.imageScanFailed(error.message ?? error.code));
    } catch (error) {
      _showMessage(l10n.imageScanFailed(error.toString()));
    } finally {
      if (mounted) setState(() => _scanningImage = false);
    }
  }

  void _setResult(String rawValue) {
    final result = classifyScanResult(rawValue);
    setState(() => _result = result);
    ref.read(scannedHistoryProvider.notifier).add(result);
  }

  Future<void> _openResult() async {
    final result = _result;
    if (result == null) return;
    if (result.actionType == ScanActionType.wifi) {
      final successMessage = context.l10n.wifiSettingsOpened;
      final failureMessage = context.l10n.wifiSettingsFailed;
      final opened = await _wifiService.openWifiSettings();
      _showMessage(opened ? successMessage : failureMessage);
      return;
    }
    final uri = Uri.tryParse(result.rawValue);
    final cannotOpenQr = context.l10n.cannotOpenQr;
    if (uri == null || !await canLaunchUrl(uri)) {
      _showMessage(cannotOpenQr);
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _copyResult() async {
    final result = _result;
    if (result == null) return;
    final message = context.l10n.scannedDataCopied;
    await Clipboard.setData(ClipboardData(text: result.rawValue));
    _showMessage(message);
  }

  Future<void> _resumeScanning() async {
    setState(() {
      _result = null;
      _handlingDetection = false;
    });
    await _controller.start();
  }

  Future<void> _toggleTorch() async {
    await _controller.toggleTorch();
    setState(() => _torchOn = !_torchOn);
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ScannerScrim extends StatelessWidget {
  const _ScannerScrim();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.20),
            Colors.transparent,
            Colors.black.withValues(alpha: 0.28),
          ],
        ),
      ),
    );
  }
}

class _ScannerFrame extends StatelessWidget {
  const _ScannerFrame();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: 240,
          height: 240,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.55),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.primary, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanResultPanel extends StatelessWidget {
  const _ScanResultPanel({
    required this.result,
    required this.onOpen,
    required this.onCopy,
    required this.onResume,
  });

  final ScanResult? result;
  final VoidCallback onOpen;
  final VoidCallback onCopy;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final active = result != null;
    final l10n = context.l10n;
    final isWifi = result?.actionType == ScanActionType.wifi;
    final isLink = result?.actionType == ScanActionType.link;
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                active
                    ? isWifi
                          ? Icons.wifi
                          : Icons.check_circle_outline
                    : Icons.center_focus_strong,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  active ? _displayTitle(context, result!) : l10n.readyToScan,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: active
                  ? _ResultDetails(result: result!)
                  : Text(l10n.scanHelp),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: active ? onOpen : null,
                icon: Icon(isWifi ? Icons.wifi : Icons.open_in_new),
                label: Text(
                  isWifi
                      ? l10n.connectWifi
                      : isLink
                      ? l10n.openLink
                      : l10n.open,
                ),
              ),
              OutlinedButton.icon(
                onPressed: active ? onCopy : null,
                icon: const Icon(Icons.copy),
                label: Text(l10n.copy),
              ),
              OutlinedButton.icon(
                onPressed: active ? onResume : null,
                icon: const Icon(Icons.center_focus_strong),
                label: Text(l10n.scanNext),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _displayTitle(BuildContext context, ScanResult result) {
    if (result.actionType == ScanActionType.wifi && result.wifi != null) {
      return result.wifi!.ssid;
    }
    if (result.actionType == ScanActionType.contact &&
        result.title.trim().isNotEmpty &&
        result.title != 'Contact card') {
      return result.title;
    }
    return scanTypeLabel(context.l10n, result.actionType);
  }
}

class _ResultDetails extends StatelessWidget {
  const _ResultDetails({required this.result});

  final ScanResult result;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final wifi = result.wifi;
    if (wifi != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailLine(label: l10n.ssid, value: wifi.ssid),
          _DetailLine(label: l10n.wifiSecurity, value: wifi.security),
          _DetailLine(
            label: l10n.wifiPassword,
            value: wifi.password.isEmpty ? l10n.noPassword : wifi.password,
          ),
          _DetailLine(
            label: l10n.wifiHidden,
            value: wifi.hidden ? l10n.yes : l10n.no,
          ),
          const SizedBox(height: 8),
          Text(result.rawValue),
        ],
      );
    }
    return Text(result.rawValue);
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value'),
    );
  }
}
