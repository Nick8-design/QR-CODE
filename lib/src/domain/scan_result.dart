enum ScanActionType { link, email, phone, sms, wifi, contact, plainText }

class WifiNetwork {
  const WifiNetwork({
    required this.ssid,
    required this.security,
    required this.password,
    required this.hidden,
  });

  final String ssid;
  final String security;
  final String password;
  final bool hidden;

  Map<String, Object?> toJson() {
    return {
      'ssid': ssid,
      'security': security,
      'password': password,
      'hidden': hidden,
    };
  }

  factory WifiNetwork.fromJson(Map<String, Object?> json) {
    return WifiNetwork(
      ssid: json['ssid'] as String? ?? '',
      security: json['security'] as String? ?? '',
      password: json['password'] as String? ?? '',
      hidden: json['hidden'] as bool? ?? false,
    );
  }
}

class ScanResult {
  ScanResult({
    required this.rawValue,
    required this.actionType,
    required this.title,
    this.wifi,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();

  final String rawValue;
  final ScanActionType actionType;
  final String title;
  final WifiNetwork? wifi;
  final DateTime savedAt;

  Map<String, Object?> toJson() {
    return {
      'rawValue': rawValue,
      'actionType': actionType.name,
      'title': title,
      'savedAt': savedAt.toIso8601String(),
      if (wifi != null) 'wifi': wifi!.toJson(),
    };
  }

  factory ScanResult.fromJson(Map<String, Object?> json) {
    final typeName = json['actionType'] as String?;
    final wifiJson = json['wifi'];
    return ScanResult(
      rawValue: json['rawValue'] as String? ?? '',
      actionType: ScanActionType.values.firstWhere(
        (type) => type.name == typeName,
        orElse: () => ScanActionType.plainText,
      ),
      title: json['title'] as String? ?? 'QR content',
      savedAt: DateTime.tryParse(json['savedAt'] as String? ?? ''),
      wifi: wifiJson is Map
          ? WifiNetwork.fromJson(Map<String, Object?>.from(wifiJson))
          : null,
    );
  }
}

ScanResult classifyScanResult(String rawValue) {
  final value = rawValue.trim();
  final uri = Uri.tryParse(value);

  if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
    return ScanResult(
      rawValue: value,
      actionType: ScanActionType.link,
      title: 'Website link',
    );
  }
  if (value.toLowerCase().startsWith('mailto:')) {
    return ScanResult(
      rawValue: value,
      actionType: ScanActionType.email,
      title: 'Email address',
    );
  }
  if (value.toLowerCase().startsWith('tel:')) {
    return ScanResult(
      rawValue: value,
      actionType: ScanActionType.phone,
      title: 'Phone number',
    );
  }
  if (value.toLowerCase().startsWith('sms:')) {
    return ScanResult(
      rawValue: value,
      actionType: ScanActionType.sms,
      title: 'SMS message',
    );
  }
  if (value.toUpperCase().startsWith('WIFI:')) {
    final wifi = parseWifiPayload(value);
    return ScanResult(
      rawValue: value,
      actionType: ScanActionType.wifi,
      title: wifi?.ssid.isNotEmpty == true ? wifi!.ssid : 'Wi-Fi network',
      wifi: wifi,
    );
  }
  if (value.toUpperCase().startsWith('BEGIN:VCARD')) {
    return ScanResult(
      rawValue: value,
      actionType: ScanActionType.contact,
      title: _vcardName(value) ?? 'Contact card',
    );
  }
  return ScanResult(
    rawValue: value,
    actionType: ScanActionType.plainText,
    title: 'Text content',
  );
}

WifiNetwork? parseWifiPayload(String rawValue) {
  final trimmed = rawValue.trim();
  if (!trimmed.toUpperCase().startsWith('WIFI:')) return null;
  final body = trimmed.substring(5);
  final fields = <String, String>{};
  final buffer = StringBuffer();
  String? key;
  var escaping = false;

  for (final codeUnit in body.codeUnits) {
    final char = String.fromCharCode(codeUnit);
    if (escaping) {
      buffer.write(char);
      escaping = false;
      continue;
    }
    if (char == r'\') {
      escaping = true;
      continue;
    }
    if (char == ':' && key == null) {
      key = buffer.toString().toUpperCase();
      buffer.clear();
      continue;
    }
    if (char == ';') {
      if (key != null) fields[key] = buffer.toString();
      key = null;
      buffer.clear();
      continue;
    }
    buffer.write(char);
  }
  if (key != null && buffer.isNotEmpty) fields[key] = buffer.toString();

  final ssid = fields['S'] ?? '';
  if (ssid.isEmpty) return null;
  final security = fields['T'] ?? 'WPA';
  return WifiNetwork(
    ssid: ssid,
    security: security == 'nopass' ? 'None' : security,
    password: fields['P'] ?? '',
    hidden: (fields['H'] ?? '').toLowerCase() == 'true',
  );
}

String? _vcardName(String value) {
  for (final line in value.split(RegExp(r'\r?\n'))) {
    if (line.toUpperCase().startsWith('FN:')) {
      final name = line.substring(3).trim();
      if (name.isNotEmpty) return name;
    }
  }
  return null;
}
