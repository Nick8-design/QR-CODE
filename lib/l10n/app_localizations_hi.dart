// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'QR स्टूडियो';

  @override
  String get create => 'बनाएं';

  @override
  String get scan => 'स्कैन';

  @override
  String get history => 'इतिहास';

  @override
  String get created => 'बनाए गए';

  @override
  String get scanned => 'स्कैन किए गए';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'भाषा';

  @override
  String get systemLanguage => 'डिवाइस भाषा';

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
  String get copy => 'कॉपी';

  @override
  String get copyData => 'Copy data';

  @override
  String get copyQrData => 'Copy QR data';

  @override
  String get clear => 'साफ करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get save => 'सहेजें';

  @override
  String get share => 'साझा करें';

  @override
  String get open => 'खोलें';

  @override
  String get openLink => 'लिंक खोलें';

  @override
  String get connectWifi => 'Wi-Fi से जुड़ें';

  @override
  String get scanNext => 'अगला स्कैन करें';

  @override
  String get flash => 'फ्लैश';

  @override
  String get scanImage => 'छवि स्कैन करें';

  @override
  String get readyToScan => 'स्कैन के लिए तैयार';

  @override
  String get scanHelp =>
      'Point the camera at a QR code or choose an image from your gallery.';

  @override
  String get noQrFound => 'इस छवि में कोई QR कोड नहीं मिला।';

  @override
  String get scanningSelectedImage => 'चुनी गई छवि स्कैन हो रही है...';

  @override
  String get imageSelectionCancelled => 'छवि चयन रद्द किया गया।';

  @override
  String get qrFoundInImage => 'छवि में QR कोड मिला।';

  @override
  String imageScanFailed(Object error) {
    return 'छवि स्कैन नहीं हो सकी: $error';
  }

  @override
  String get cannotOpenQr => 'This QR data cannot be opened automatically.';

  @override
  String get wifiSettingsOpened => 'Wi-Fi settings opened.';

  @override
  String get wifiSettingsFailed => 'Could not open Wi-Fi settings.';

  @override
  String get copied => 'कॉपी किया गया।';

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
  String get generate => 'जनरेट करें';

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
  String get text => 'टेक्स्ट';

  @override
  String get website => 'वेबसाइट';

  @override
  String get email => 'ईमेल';

  @override
  String get phone => 'फ़ोन';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => 'संपर्क';

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
  String get password => 'पासवर्ड';

  @override
  String get security => 'Security';

  @override
  String get hidden => 'Hidden';

  @override
  String get noSecurity => 'None';

  @override
  String get organization => 'Organization';

  @override
  String get required => 'आवश्यक';

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
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

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
