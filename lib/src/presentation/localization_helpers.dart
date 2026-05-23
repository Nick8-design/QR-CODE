import 'package:flutter/material.dart';
import 'package:qr_code/l10n/app_localizations.dart';

import '../domain/qr_payload.dart';
import '../domain/scan_result.dart';

extension LocalizationContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

String payloadTypeLabel(AppLocalizations l10n, QrPayloadType type) {
  return switch (type) {
    QrPayloadType.text => l10n.text,
    QrPayloadType.url => l10n.website,
    QrPayloadType.email => l10n.email,
    QrPayloadType.phone => l10n.phone,
    QrPayloadType.sms => l10n.sms,
    QrPayloadType.wifi => l10n.wifi,
    QrPayloadType.contact => l10n.contact,
    QrPayloadType.uploadedFile => l10n.fileLink,
  };
}

String scanTypeLabel(AppLocalizations l10n, ScanActionType type) {
  return switch (type) {
    ScanActionType.link => l10n.websiteLink,
    ScanActionType.email => l10n.emailAddressTitle,
    ScanActionType.phone => l10n.phoneNumberTitle,
    ScanActionType.sms => l10n.smsMessage,
    ScanActionType.wifi => l10n.wifiNetwork,
    ScanActionType.contact => l10n.contactCard,
    ScanActionType.plainText => l10n.textContent,
  };
}

String scanCategoryLabel(AppLocalizations l10n, ScanActionType type) {
  return switch (type) {
    ScanActionType.link => l10n.links,
    ScanActionType.wifi => l10n.wifiNetworks,
    ScanActionType.contact => l10n.contacts,
    ScanActionType.sms => l10n.messages,
    ScanActionType.phone => l10n.calls,
    ScanActionType.email => l10n.emails,
    ScanActionType.plainText => l10n.texts,
  };
}

String shortDateTime(DateTime value) {
  final local = value.toLocal();
  final year = local.year.toString().padLeft(4, '0');
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$year-$month-$day $hour:$minute';
}
