import 'dart:async';

import 'package:flutter/material.dart';

import '../infrastructure/rate_prompt_controller.dart';
import 'generate_page.dart';
import 'history_page.dart';
import 'localization_helpers.dart';
import 'scan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ratePromptController = RatePromptController();
  int _selectedIndex = 0;
  bool _rateDialogShowing = false;
  Timer? _ratePromptTimer;

  static const _pages = [GeneratePage(), ScanPage(), HistoryPage()];

  @override
  void initState() {
    super.initState();
    _scheduleRatePrompt(RatePromptController.initialPromptDelay);
  }

  @override
  void dispose() {
    _ratePromptTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.qr_code_2_outlined),
            selectedIcon: const Icon(Icons.qr_code_2),
            label: l10n.create,
          ),
          NavigationDestination(
            icon: const Icon(Icons.document_scanner_outlined),
            selectedIcon: const Icon(Icons.document_scanner),
            label: l10n.scan,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: l10n.history,
          ),
        ],
      ),
    );
  }

  void _scheduleRatePrompt(Duration delay) {
    _ratePromptTimer?.cancel();
    _ratePromptTimer = Timer(delay, () async {
      if (!mounted || _rateDialogShowing) return;
      if (!await _ratePromptController.shouldPromptNow()) return;
      if (!mounted) return;
      await _showRateDialog();
    });
  }

  Future<void> _showRateDialog() async {
    _rateDialogShowing = true;
    final result = await showDialog<_RatePromptChoice>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.star_rate_rounded),
          title: const Text('Enjoying QR Studio?'),
          content: const Text(
            'Your rating and feedback help improve the app during testing.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(_RatePromptChoice.later),
              child: const Text('Later'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(_RatePromptChoice.rate),
              child: const Text('Rate now'),
            ),
          ],
        );
      },
    );
    _rateDialogShowing = false;

    if (!mounted || result == null) return;
    switch (result) {
      case _RatePromptChoice.rate:
        final opened = await _ratePromptController.openPlayStoreForRating();
        if (!opened && mounted) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(content: Text('Could not open Play Store.')),
            );
        }
      case _RatePromptChoice.later:
        await _ratePromptController.remindLater();
        _scheduleRatePrompt(RatePromptController.laterDelay);
    }
  }
}

enum _RatePromptChoice { rate, later }
