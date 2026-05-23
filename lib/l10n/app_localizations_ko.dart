// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'QR 스튜디오';

  @override
  String get create => '만들기';

  @override
  String get scan => '스캔';

  @override
  String get history => '기록';

  @override
  String get created => '생성됨';

  @override
  String get scanned => '스캔됨';

  @override
  String get settings => 'Settings';

  @override
  String get language => '언어';

  @override
  String get systemLanguage => '기기 언어';

  @override
  String get english => 'English';

  @override
  String get swahili => 'Kiswahili';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'العربية';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get chinese => '中文';

  @override
  String get portuguese => 'Português';

  @override
  String get german => 'Deutsch';

  @override
  String get italian => 'Italiano';

  @override
  String get japanese => '日本語';

  @override
  String get korean => '한국어';

  @override
  String get copy => '복사';

  @override
  String get copyData => 'Copy data';

  @override
  String get copyQrData => 'Copy QR data';

  @override
  String get clear => '지우기';

  @override
  String get delete => '삭제';

  @override
  String get save => '저장';

  @override
  String get share => '공유';

  @override
  String get open => '열기';

  @override
  String get openLink => '링크 열기';

  @override
  String get connectWifi => 'Wi-Fi 연결';

  @override
  String get scanNext => '다음 스캔';

  @override
  String get flash => '플래시';

  @override
  String get scanImage => '이미지 스캔';

  @override
  String get readyToScan => '스캔 준비 완료';

  @override
  String get scanHelp =>
      'Point the camera at a QR code or choose an image from your gallery.';

  @override
  String get noQrFound => '이 이미지에서 QR 코드를 찾을 수 없습니다.';

  @override
  String get scanningSelectedImage => '선택한 이미지를 스캔하는 중...';

  @override
  String get imageSelectionCancelled => '이미지 선택이 취소되었습니다.';

  @override
  String get qrFoundInImage => '이미지에서 QR 코드를 찾았습니다.';

  @override
  String imageScanFailed(Object error) {
    return '이미지를 스캔할 수 없습니다: $error';
  }

  @override
  String get cannotOpenQr => 'This QR data cannot be opened automatically.';

  @override
  String get wifiSettingsOpened => 'Wi-Fi settings opened.';

  @override
  String get wifiSettingsFailed => 'Could not open Wi-Fi settings.';

  @override
  String get copied => '복사됨.';

  @override
  String get scannedDataCopied => 'Scanned data copied.';

  @override
  String get generatedEmpty => 'Generated QR codes will appear here.';

  @override
  String get scannedEmpty => 'Scanned QR codes will appear here.';

  @override
  String generatedAt(Object time) {
    return 'Saved $time';
  }

  @override
  String get qrType => 'QR type';

  @override
  String get fileType => 'File type';

  @override
  String get document => 'Document';

  @override
  String get image => 'Image';

  @override
  String get video => 'Video';

  @override
  String get anyFile => 'Any file';

  @override
  String get pickUploadCreate => 'Pick, upload, and create';

  @override
  String get uploading => 'Uploading...';

  @override
  String get generate => '생성';

  @override
  String get headerDescription =>
      'Create codes for text, links, contacts, Wi-Fi, messages, calls, and uploaded files.';

  @override
  String get fileUploaded => 'File uploaded and QR created.';

  @override
  String uploadFailed(Object error) {
    return 'Upload failed: $error';
  }

  @override
  String get qrDataCopied => 'QR data copied.';

  @override
  String get qrSaved => 'QR saved to gallery.';

  @override
  String exportFailed(Object error) {
    return 'Could not export QR: $error';
  }

  @override
  String get text => '텍스트';

  @override
  String get website => '웹사이트';

  @override
  String get email => '이메일';

  @override
  String get phone => '전화';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => '연락처';

  @override
  String get fileLink => 'File link';

  @override
  String get websiteUrl => 'Website URL';

  @override
  String get emailAddress => 'Email address';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get networkName => 'Network name';

  @override
  String get fullName => 'Full name';

  @override
  String get file => 'File';

  @override
  String get subject => 'Subject';

  @override
  String get message => 'Message';

  @override
  String get password => '비밀번호';

  @override
  String get security => 'Security';

  @override
  String get hidden => 'Hidden';

  @override
  String get noSecurity => 'None';

  @override
  String get organization => 'Organization';

  @override
  String get required => '필수';

  @override
  String get validEmail => 'Enter a valid email address';

  @override
  String get websiteLink => 'Website link';

  @override
  String get emailAddressTitle => 'Email address';

  @override
  String get phoneNumberTitle => 'Phone number';

  @override
  String get smsMessage => 'SMS message';

  @override
  String get wifiNetwork => 'Wi-Fi network';

  @override
  String get contactCard => 'Contact card';

  @override
  String get textContent => 'Text content';

  @override
  String get unknownQr => 'QR content';

  @override
  String get ssid => 'Network';

  @override
  String get wifiPassword => 'Password';

  @override
  String get wifiSecurity => 'Security';

  @override
  String get wifiHidden => 'Hidden network';

  @override
  String get yes => '예';

  @override
  String get no => '아니요';

  @override
  String get noPassword => 'No password';

  @override
  String get rawData => 'Raw data';

  @override
  String get links => 'Links';

  @override
  String get wifiNetworks => 'Wi-Fi networks';

  @override
  String get contacts => 'Contacts';

  @override
  String get messages => 'Messages';

  @override
  String get calls => 'Calls';

  @override
  String get emails => 'Emails';

  @override
  String get texts => 'Texts';

  @override
  String get files => 'Files';

  @override
  String get other => 'Other';
}
