import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code/l10n/app_localizations.dart';

import '../application/locale_controller.dart';

class LanguageMenuButton extends ConsumerWidget {
  const LanguageMenuButton({super.key});

  static const _locales = [
    Locale('en'),
    Locale('sw'),
    Locale('es'),
    Locale('fr'),
    Locale('ar'),
    Locale('hi'),
    Locale('zh'),
    Locale('pt'),
    Locale('de'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selected = ref.watch(localeProvider);
    return PopupMenuButton<String>(
      tooltip: l10n.language,
      icon: const Icon(Icons.translate),
      onSelected: (code) {
        ref
            .read(localeProvider.notifier)
            .setLocale(code == 'system' ? null : Locale(code));
      },
      itemBuilder: (context) {
        return [
          CheckedPopupMenuItem(
            value: 'system',
            checked: selected == null,
            child: Text(l10n.systemLanguage),
          ),
          ..._locales.map(
            (locale) => CheckedPopupMenuItem(
              value: locale.languageCode,
              checked: selected?.languageCode == locale.languageCode,
              child: Text(_languageName(l10n, locale.languageCode)),
            ),
          ),
        ];
      },
    );
  }

  String _languageName(AppLocalizations l10n, String code) {
    return switch (code) {
      'en' => l10n.english,
      'sw' => l10n.swahili,
      'es' => l10n.spanish,
      'fr' => l10n.french,
      'ar' => l10n.arabic,
      'hi' => l10n.hindi,
      'zh' => l10n.chinese,
      'pt' => l10n.portuguese,
      'de' => l10n.german,
      'it' => l10n.italian,
      'ja' => l10n.japanese,
      'ko' => l10n.korean,
      _ => code,
    };
  }
}
