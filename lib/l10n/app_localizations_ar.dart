// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'استوديو QR';

  @override
  String get create => 'إنشاء';

  @override
  String get scan => 'مسح';

  @override
  String get history => 'السجل';

  @override
  String get created => 'تم إنشاؤها';

  @override
  String get scanned => 'تم مسحها';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'اللغة';

  @override
  String get systemLanguage => 'لغة الجهاز';

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
  String get copy => 'نسخ';

  @override
  String get copyData => 'Copy data';

  @override
  String get copyQrData => 'Copy QR data';

  @override
  String get clear => 'مسح';

  @override
  String get delete => 'حذف';

  @override
  String get save => 'حفظ';

  @override
  String get share => 'مشاركة';

  @override
  String get open => 'فتح';

  @override
  String get openLink => 'فتح الرابط';

  @override
  String get connectWifi => 'الاتصال بالواي فاي';

  @override
  String get scanNext => 'مسح التالي';

  @override
  String get flash => 'الفلاش';

  @override
  String get scanImage => 'مسح صورة';

  @override
  String get readyToScan => 'جاهز للمسح';

  @override
  String get scanHelp =>
      'Point the camera at a QR code or choose an image from your gallery.';

  @override
  String get noQrFound => 'لم يتم العثور على رمز QR في هذه الصورة.';

  @override
  String get scanningSelectedImage => 'جارٍ مسح الصورة المحددة...';

  @override
  String get imageSelectionCancelled => 'تم إلغاء اختيار الصورة.';

  @override
  String get qrFoundInImage => 'تم العثور على رمز QR في الصورة.';

  @override
  String imageScanFailed(Object error) {
    return 'تعذر مسح الصورة: $error';
  }

  @override
  String get cannotOpenQr => 'This QR data cannot be opened automatically.';

  @override
  String get wifiSettingsOpened => 'Wi-Fi settings opened.';

  @override
  String get wifiSettingsFailed => 'Could not open Wi-Fi settings.';

  @override
  String get copied => 'تم النسخ.';

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
  String get generate => 'إنشاء';

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
  String get text => 'نص';

  @override
  String get website => 'موقع ويب';

  @override
  String get email => 'بريد إلكتروني';

  @override
  String get phone => 'هاتف';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => 'جهة اتصال';

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
  String get password => 'كلمة المرور';

  @override
  String get security => 'Security';

  @override
  String get hidden => 'Hidden';

  @override
  String get noSecurity => 'None';

  @override
  String get organization => 'Organization';

  @override
  String get required => 'مطلوب';

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
  String get yes => 'نعم';

  @override
  String get no => 'لا';

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
