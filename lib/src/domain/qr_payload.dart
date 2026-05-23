enum QrPayloadType { text, url, email, phone, sms, wifi, contact, uploadedFile }

extension QrPayloadTypeLabel on QrPayloadType {
  String get label {
    switch (this) {
      case QrPayloadType.text:
        return 'Text';
      case QrPayloadType.url:
        return 'Website';
      case QrPayloadType.email:
        return 'Email';
      case QrPayloadType.phone:
        return 'Phone';
      case QrPayloadType.sms:
        return 'SMS';
      case QrPayloadType.wifi:
        return 'Wi-Fi';
      case QrPayloadType.contact:
        return 'Contact';
      case QrPayloadType.uploadedFile:
        return 'File link';
    }
  }
}

class QrPayload {
  QrPayload({
    required this.type,
    required this.data,
    required this.title,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final QrPayloadType type;
  final String data;
  final String title;
  final DateTime createdAt;

  Map<String, Object?> toJson() {
    return {
      'type': type.name,
      'data': data,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory QrPayload.fromJson(Map<String, Object?> json) {
    final typeName = json['type'] as String?;
    return QrPayload(
      type: QrPayloadType.values.firstWhere(
        (type) => type.name == typeName,
        orElse: () => QrPayloadType.text,
      ),
      data: json['data'] as String? ?? '',
      title: json['title'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}

String buildEmailPayload(String email, String subject, String body) {
  final query = <String, String>{
    if (subject.trim().isNotEmpty) 'subject': subject.trim(),
    if (body.trim().isNotEmpty) 'body': body.trim(),
  };
  return Uri(
    scheme: 'mailto',
    path: email.trim(),
    queryParameters: query.isEmpty ? null : query,
  ).toString();
}

String buildSmsPayload(String phone, String message) {
  final query = message.trim().isEmpty ? null : {'body': message.trim()};
  return Uri(
    scheme: 'sms',
    path: phone.trim(),
    queryParameters: query,
  ).toString();
}

String buildWifiPayload({
  required String ssid,
  required String password,
  required String security,
  required bool hidden,
}) {
  final escapedSsid = _escapeWifiValue(ssid.trim());
  final escapedPassword = _escapeWifiValue(password.trim());
  final auth = security == 'None' ? 'nopass' : security;
  return 'WIFI:T:$auth;S:$escapedSsid;P:$escapedPassword;H:$hidden;;';
}

String buildContactPayload({
  required String name,
  required String phone,
  required String email,
  required String organization,
}) {
  final lines = [
    'BEGIN:VCARD',
    'VERSION:3.0',
    'FN:${name.trim()}',
    if (organization.trim().isNotEmpty) 'ORG:${organization.trim()}',
    if (phone.trim().isNotEmpty) 'TEL:${phone.trim()}',
    if (email.trim().isNotEmpty) 'EMAIL:${email.trim()}',
    'END:VCARD',
  ];
  return lines.join('\n');
}

String normalizeUrl(String value) {
  final trimmed = value.trim();
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return trimmed;
  }
  return 'https://$trimmed';
}

String _escapeWifiValue(String value) {
  return value
      .replaceAll(r'\', r'\\')
      .replaceAll(';', r'\;')
      .replaceAll(',', r'\,')
      .replaceAll(':', r'\:');
}
