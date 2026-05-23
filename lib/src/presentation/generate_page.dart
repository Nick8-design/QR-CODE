import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../application/history_controller.dart';
import '../domain/qr_payload.dart';
import '../infrastructure/file_upload_service.dart';
import '../infrastructure/qr_export_service.dart';
import 'app_chrome.dart';
import 'language_menu_button.dart';
import 'localization_helpers.dart';
import 'rate_app_action.dart';

class GeneratePage extends ConsumerStatefulWidget {
  const GeneratePage({super.key});

  @override
  ConsumerState<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends ConsumerState<GeneratePage> {
  final _formKey = GlobalKey<FormState>();
  final _qrKey = GlobalKey();
  final _textController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  final _passwordController = TextEditingController();
  final _organizationController = TextEditingController();
  final _uploader = FileUploadService();
  final _exporter = QrExportService();

  QrPayloadType _type = QrPayloadType.text;
  QrPayload? _payload;
  String _fileType = 'document';
  String _wifiSecurity = 'WPA';
  bool _wifiHidden = false;
  bool _uploading = false;

  @override
  void dispose() {
    _textController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    _passwordController.dispose();
    _organizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        actions: [
          const LanguageMenuButton(),
          const RateAppAction(),
          IconButton(
            tooltip: context.l10n.copyQrData,
            onPressed: _payload == null ? null : _copyPayload,
            icon: const Icon(Icons.copy_all_outlined),
          ),
          IconButton(
            tooltip: context.l10n.clear,
            onPressed: _payload == null ? null : _clear,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              _Header(colorScheme: colorScheme),
              const SizedBox(height: 16),
              AppPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<QrPayloadType>(
                      initialValue: _type,
                      decoration: InputDecoration(
                        labelText: context.l10n.qrType,
                      ),
                      items: QrPayloadType.values
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Row(
                                children: [
                                  Icon(_iconFor(type), size: 20),
                                  const SizedBox(width: 10),
                                  Text(payloadTypeLabel(context.l10n, type)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _type = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: _InputPanel(
                        type: _type,
                        textController: _textController,
                        subjectController: _subjectController,
                        bodyController: _bodyController,
                        passwordController: _passwordController,
                        organizationController: _organizationController,
                        fileType: _fileType,
                        wifiSecurity: _wifiSecurity,
                        wifiHidden: _wifiHidden,
                        uploading: _uploading,
                        onFileTypeChanged: (value) {
                          setState(() => _fileType = value);
                        },
                        onWifiSecurityChanged: (value) {
                          setState(() => _wifiSecurity = value);
                        },
                        onWifiHiddenChanged: (value) {
                          setState(() => _wifiHidden = value);
                        },
                        onPickFile: _pickAndUploadFile,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _type == QrPayloadType.uploadedFile
                          ? null
                          : _generate,
                      icon: const Icon(Icons.auto_awesome),
                      label: Text(context.l10n.generate),
                    ),
                  ],
                ),
              ),
              if (_payload != null) ...[
                const SizedBox(height: 20),
                _QrPreview(
                  qrKey: _qrKey,
                  payload: _payload!,
                  onSave: _saveQr,
                  onShare: _shareQr,
                  onCopy: _copyPayload,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndUploadFile() async {
    setState(() => _uploading = true);
    final fileUploadedMessage = context.l10n.fileUploaded;
    try {
      final selected = await _uploader.pickFile(_fileType);
      if (selected == null) return;
      final url = await _uploader.upload(selected, _fileType);
      _setPayload(
        QrPayload(
          type: QrPayloadType.uploadedFile,
          title: selected.name,
          data: url,
        ),
      );
      _showMessage(fileUploadedMessage);
    } catch (error) {
      if (!mounted) return;
      _showMessage(context.l10n.uploadFailed(error.toString()));
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  void _generate() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final primary = _textController.text.trim();
    final l10n = context.l10n;
    final payload = switch (_type) {
      QrPayloadType.text => QrPayload(
        type: _type,
        title: l10n.text,
        data: primary,
      ),
      QrPayloadType.url => QrPayload(
        type: _type,
        title: primary,
        data: normalizeUrl(primary),
      ),
      QrPayloadType.email => QrPayload(
        type: _type,
        title: primary,
        data: buildEmailPayload(
          primary,
          _subjectController.text,
          _bodyController.text,
        ),
      ),
      QrPayloadType.phone => QrPayload(
        type: _type,
        title: primary,
        data: 'tel:$primary',
      ),
      QrPayloadType.sms => QrPayload(
        type: _type,
        title: primary,
        data: buildSmsPayload(primary, _bodyController.text),
      ),
      QrPayloadType.wifi => QrPayload(
        type: _type,
        title: primary,
        data: buildWifiPayload(
          ssid: primary,
          password: _passwordController.text,
          security: _wifiSecurity,
          hidden: _wifiHidden,
        ),
      ),
      QrPayloadType.contact => QrPayload(
        type: _type,
        title: primary,
        data: buildContactPayload(
          name: primary,
          phone: _subjectController.text,
          email: _bodyController.text,
          organization: _organizationController.text,
        ),
      ),
      QrPayloadType.uploadedFile => null,
    };
    if (payload != null) _setPayload(payload);
  }

  void _setPayload(QrPayload payload) {
    setState(() => _payload = payload);
    ref.read(generatedHistoryProvider.notifier).add(payload);
  }

  Future<void> _copyPayload() async {
    final payload = _payload;
    if (payload == null) return;
    final message = context.l10n.qrDataCopied;
    await Clipboard.setData(ClipboardData(text: payload.data));
    _showMessage(message);
  }

  Future<void> _saveQr() async {
    final message = context.l10n.qrSaved;
    final file = await _captureToFile();
    if (file == null) return;
    await _exporter.saveToGallery(file);
    _showMessage(message);
  }

  Future<void> _shareQr() async {
    final file = await _captureToFile();
    if (file == null) return;
    await _exporter.share(file, text: _payload?.title);
  }

  Future<File?> _captureToFile() async {
    final exportFailed = context.l10n.exportFailed;
    try {
      final context = _qrKey.currentContext;
      if (context == null) return null;
      final boundary = context.findRenderObject() as RenderRepaintBoundary;
      final bytes = await _exporter.capture(boundary);
      return _exporter.writeTempPng(
        bytes,
        'qr-${DateTime.now().millisecondsSinceEpoch}.png',
      );
    } catch (error) {
      _showMessage(exportFailed(error.toString()));
      return null;
    }
  }

  void _clear() {
    setState(() => _payload = null);
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.tertiaryContainer.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.14),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.qr_code_scanner,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.headerDescription,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputPanel extends StatelessWidget {
  const _InputPanel({
    required this.type,
    required this.textController,
    required this.subjectController,
    required this.bodyController,
    required this.passwordController,
    required this.organizationController,
    required this.fileType,
    required this.wifiSecurity,
    required this.wifiHidden,
    required this.uploading,
    required this.onFileTypeChanged,
    required this.onWifiSecurityChanged,
    required this.onWifiHiddenChanged,
    required this.onPickFile,
  });

  final QrPayloadType type;
  final TextEditingController textController;
  final TextEditingController subjectController;
  final TextEditingController bodyController;
  final TextEditingController passwordController;
  final TextEditingController organizationController;
  final String fileType;
  final String wifiSecurity;
  final bool wifiHidden;
  final bool uploading;
  final ValueChanged<String> onFileTypeChanged;
  final ValueChanged<String> onWifiSecurityChanged;
  final ValueChanged<bool> onWifiHiddenChanged;
  final VoidCallback onPickFile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (type == QrPayloadType.uploadedFile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            initialValue: fileType,
            decoration: InputDecoration(labelText: l10n.fileType),
            items: [
              DropdownMenuItem(value: 'document', child: Text(l10n.document)),
              DropdownMenuItem(value: 'image', child: Text(l10n.image)),
              DropdownMenuItem(value: 'video', child: Text(l10n.video)),
              DropdownMenuItem(value: 'any', child: Text(l10n.anyFile)),
            ],
            onChanged: (value) {
              if (value != null) onFileTypeChanged(value);
            },
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: uploading ? null : onPickFile,
            icon: uploading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.upload_file),
            label: Text(uploading ? l10n.uploading : l10n.pickUploadCreate),
          ),
        ],
      );
    }

    return Column(
      children: [
        TextFormField(
          controller: textController,
          keyboardType: _keyboardFor(type),
          decoration: InputDecoration(labelText: _primaryLabel(l10n, type)),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return l10n.required;
            if (type == QrPayloadType.email && !value.contains('@')) {
              return l10n.validEmail;
            }
            return null;
          },
        ),
        if (type == QrPayloadType.email) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: subjectController,
            decoration: InputDecoration(labelText: l10n.subject),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: bodyController,
            decoration: InputDecoration(labelText: l10n.message),
            minLines: 2,
            maxLines: 4,
          ),
        ],
        if (type == QrPayloadType.sms) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: bodyController,
            decoration: InputDecoration(labelText: l10n.message),
            minLines: 2,
            maxLines: 4,
          ),
        ],
        if (type == QrPayloadType.wifi) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: l10n.password),
            obscureText: true,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: wifiSecurity,
                  decoration: InputDecoration(labelText: l10n.security),
                  items: [
                    const DropdownMenuItem(
                      value: 'WPA',
                      child: Text('WPA/WPA2'),
                    ),
                    const DropdownMenuItem(value: 'WEP', child: Text('WEP')),
                    DropdownMenuItem(
                      value: 'None',
                      child: Text(l10n.noSecurity),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) onWifiSecurityChanged(value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.hidden),
                  value: wifiHidden,
                  onChanged: onWifiHiddenChanged,
                ),
              ),
            ],
          ),
        ],
        if (type == QrPayloadType.contact) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: organizationController,
            decoration: InputDecoration(labelText: l10n.organization),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: subjectController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: l10n.phone),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: bodyController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: l10n.email),
          ),
        ],
      ],
    );
  }
}

class _QrPreview extends StatelessWidget {
  const _QrPreview({
    required this.qrKey,
    required this.payload,
    required this.onSave,
    required this.onShare,
    required this.onCopy,
  });

  final GlobalKey qrKey;
  final QrPayload payload;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return AppPanel(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.qr_code_2, color: colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  payload.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RepaintBoundary(
            key: qrKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                data: payload.data,
                version: QrVersions.auto,
                size: 230,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.black,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              IconButton.filledTonal(
                tooltip: l10n.save,
                onPressed: onSave,
                icon: const Icon(Icons.download),
              ),
              IconButton.filledTonal(
                tooltip: l10n.share,
                onPressed: onShare,
                icon: const Icon(Icons.ios_share),
              ),
              IconButton.filledTonal(
                tooltip: l10n.copyData,
                onPressed: onCopy,
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

IconData _iconFor(QrPayloadType type) {
  return switch (type) {
    QrPayloadType.text => Icons.notes,
    QrPayloadType.url => Icons.link,
    QrPayloadType.email => Icons.mail_outline,
    QrPayloadType.phone => Icons.call_outlined,
    QrPayloadType.sms => Icons.sms_outlined,
    QrPayloadType.wifi => Icons.wifi,
    QrPayloadType.contact => Icons.badge_outlined,
    QrPayloadType.uploadedFile => Icons.cloud_upload_outlined,
  };
}

TextInputType _keyboardFor(QrPayloadType type) {
  return switch (type) {
    QrPayloadType.url => TextInputType.url,
    QrPayloadType.email => TextInputType.emailAddress,
    QrPayloadType.phone || QrPayloadType.sms => TextInputType.phone,
    _ => TextInputType.text,
  };
}

String _primaryLabel(dynamic l10n, QrPayloadType type) {
  return switch (type) {
    QrPayloadType.text => l10n.text,
    QrPayloadType.url => l10n.websiteUrl,
    QrPayloadType.email => l10n.emailAddress,
    QrPayloadType.phone => l10n.phoneNumber,
    QrPayloadType.sms => l10n.phoneNumber,
    QrPayloadType.wifi => l10n.networkName,
    QrPayloadType.contact => l10n.fullName,
    QrPayloadType.uploadedFile => l10n.file,
  };
}
