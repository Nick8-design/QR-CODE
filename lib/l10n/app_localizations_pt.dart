// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Estúdio QR';

  @override
  String get create => 'Criar';

  @override
  String get scan => 'Escanear';

  @override
  String get history => 'Histórico';

  @override
  String get created => 'Criados';

  @override
  String get scanned => 'Escaneados';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma do dispositivo';

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
  String get copy => 'Copiar';

  @override
  String get copyData => 'Copy data';

  @override
  String get copyQrData => 'Copy QR data';

  @override
  String get clear => 'Limpar';

  @override
  String get delete => 'Excluir';

  @override
  String get save => 'Salvar';

  @override
  String get share => 'Compartilhar';

  @override
  String get open => 'Abrir';

  @override
  String get openLink => 'Abrir link';

  @override
  String get connectWifi => 'Conectar Wi-Fi';

  @override
  String get scanNext => 'Escanear próximo';

  @override
  String get flash => 'Flash';

  @override
  String get scanImage => 'Escanear imagem';

  @override
  String get readyToScan => 'Pronto para escanear';

  @override
  String get scanHelp =>
      'Point the camera at a QR code or choose an image from your gallery.';

  @override
  String get noQrFound => 'Nenhum código QR encontrado nessa imagem.';

  @override
  String get scanningSelectedImage => 'Escaneando imagem selecionada...';

  @override
  String get imageSelectionCancelled => 'Seleção de imagem cancelada.';

  @override
  String get qrFoundInImage => 'Código QR encontrado na imagem.';

  @override
  String imageScanFailed(Object error) {
    return 'Não foi possível escanear a imagem: $error';
  }

  @override
  String get cannotOpenQr => 'This QR data cannot be opened automatically.';

  @override
  String get wifiSettingsOpened => 'Wi-Fi settings opened.';

  @override
  String get wifiSettingsFailed => 'Could not open Wi-Fi settings.';

  @override
  String get copied => 'Copiado.';

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
  String get generate => 'Gerar';

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
  String get text => 'Texto';

  @override
  String get website => 'Site';

  @override
  String get email => 'E-mail';

  @override
  String get phone => 'Telefone';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => 'Contato';

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
  String get password => 'Senha';

  @override
  String get security => 'Security';

  @override
  String get hidden => 'Hidden';

  @override
  String get noSecurity => 'None';

  @override
  String get organization => 'Organization';

  @override
  String get required => 'Obrigatório';

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
  String get yes => 'Sim';

  @override
  String get no => 'Não';

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
