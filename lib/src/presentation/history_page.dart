import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/history_controller.dart';
import '../domain/qr_payload.dart';
import '../domain/scan_result.dart';
import '../infrastructure/wifi_connect_service.dart';
import 'app_chrome.dart';
import 'language_menu_button.dart';
import 'localization_helpers.dart';
import 'rate_app_action.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generated = ref.watch(generatedHistoryProvider);
    final scanned = ref.watch(scannedHistoryProvider);
    final l10n = context.l10n;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.history),
          actions: const [LanguageMenuButton(), RateAppAction()],
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.created),
              Tab(text: l10n.scanned),
            ],
          ),
        ),
        body: AppBackground(
          child: TabBarView(
            children: [
              _HistoryList(
                emptyText: l10n.generatedEmpty,
                emptyIcon: Icons.qr_code_2,
                itemCount: generated.length,
                onClear: () {
                  ref.read(generatedHistoryProvider.notifier).clear();
                },
                itemBuilder: (context, index) {
                  final item = generated[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.qr_code_2),
                      title: Text(
                        item.type == QrPayloadType.text
                            ? l10n.text
                            : item.title,
                      ),
                      subtitle: Text(
                        '${l10n.generatedAt(shortDateTime(item.createdAt))}\n${item.data}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Wrap(
                        spacing: 4,
                        children: [
                          IconButton(
                            tooltip: l10n.copy,
                            icon: const Icon(Icons.copy),
                            onPressed: () => _copy(context, item.data),
                          ),
                          IconButton(
                            tooltip: l10n.delete,
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              ref
                                  .read(generatedHistoryProvider.notifier)
                                  .delete(item);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              _ScannedHistoryList(
                scanned: scanned,
                onClear: () {
                  ref.read(scannedHistoryProvider.notifier).clear();
                },
                onDelete: (item) {
                  ref.read(scannedHistoryProvider.notifier).delete(item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(context.l10n.copied)));
  }
}

class _ScannedHistoryList extends StatelessWidget {
  const _ScannedHistoryList({
    required this.scanned,
    required this.onClear,
    required this.onDelete,
  });

  final List<ScanResult> scanned;
  final VoidCallback onClear;
  final ValueChanged<ScanResult> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (scanned.isEmpty) {
      return EmptyState(
        icon: Icons.document_scanner_outlined,
        message: l10n.scannedEmpty,
      );
    }

    final grouped = <ScanActionType, List<ScanResult>>{};
    for (final item in scanned) {
      grouped.putIfAbsent(item.actionType, () => []).add(item);
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.delete_outline),
            label: Text(l10n.clear),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              for (final entry in grouped.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      leading: Icon(_iconForScan(entry.key)),
                      title: Text(scanCategoryLabel(l10n, entry.key)),
                      children: [
                        for (final item in entry.value)
                          _ScannedTile(item: item, onDelete: onDelete),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScannedTile extends StatelessWidget {
  const _ScannedTile({required this.item, required this.onDelete});

  final ScanResult item;
  final ValueChanged<ScanResult> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      leading: Icon(
        _iconForScan(item.actionType),
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(_titleFor(context, item)),
      subtitle: Text(
        _subtitleFor(context, item),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => _open(context, item),
      trailing: Wrap(
        spacing: 4,
        children: [
          IconButton(
            tooltip: l10n.copy,
            icon: const Icon(Icons.copy),
            onPressed: () => _copy(context, item.rawValue),
          ),
          IconButton(
            tooltip: l10n.delete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => onDelete(item),
          ),
        ],
      ),
    );
  }

  String _titleFor(BuildContext context, ScanResult item) {
    if (item.wifi != null) return item.wifi!.ssid;
    if (item.actionType == ScanActionType.contact &&
        item.title.trim().isNotEmpty &&
        item.title != 'Contact card') {
      return item.title;
    }
    return scanTypeLabel(context.l10n, item.actionType);
  }

  String _subtitleFor(BuildContext context, ScanResult item) {
    final l10n = context.l10n;
    final saved = l10n.generatedAt(shortDateTime(item.savedAt));
    final wifi = item.wifi;
    if (wifi != null) {
      final password = wifi.password.isEmpty ? l10n.noPassword : wifi.password;
      return '$saved\n${l10n.wifiSecurity}: ${wifi.security}  ${l10n.wifiPassword}: $password';
    }
    return '$saved\n${item.rawValue}';
  }

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(context.l10n.copied)));
  }

  Future<void> _open(BuildContext context, ScanResult item) async {
    if (item.actionType == ScanActionType.wifi) {
      await WifiConnectService().openWifiSettings();
      return;
    }
    final uri = Uri.tryParse(item.rawValue);
    if (uri == null || !await canLaunchUrl(uri)) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({
    required this.emptyText,
    required this.emptyIcon,
    required this.itemCount,
    required this.itemBuilder,
    required this.onClear,
  });

  final String emptyText;
  final IconData emptyIcon;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (itemCount == 0) {
      return EmptyState(icon: emptyIcon, message: emptyText);
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.delete_outline),
            label: Text(l10n.clear),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
          ),
        ),
      ],
    );
  }
}

IconData _iconForScan(ScanActionType type) {
  return switch (type) {
    ScanActionType.link => Icons.link,
    ScanActionType.email => Icons.mail_outline,
    ScanActionType.phone => Icons.call_outlined,
    ScanActionType.sms => Icons.sms_outlined,
    ScanActionType.wifi => Icons.wifi,
    ScanActionType.contact => Icons.badge_outlined,
    ScanActionType.plainText => Icons.notes,
  };
}
