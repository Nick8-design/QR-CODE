// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'QR Studio';

  @override
  String get create => 'Erstellen';

  @override
  String get scan => 'Scannen';

  @override
  String get history => 'Verlauf';

  @override
  String get created => 'Erstellt';

  @override
  String get scanned => 'Gescannt';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get systemLanguage => 'Gerätesprache';

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
  String get copy => 'Kopieren';

  @override
  String get copyData => 'Daten kopieren';

  @override
  String get copyQrData => 'QR-Daten kopieren';

  @override
  String get clear => 'Leeren';

  @override
  String get delete => 'Löschen';

  @override
  String get save => 'Speichern';

  @override
  String get share => 'Teilen';

  @override
  String get open => 'Öffnen';

  @override
  String get openLink => 'Link öffnen';

  @override
  String get connectWifi => 'Mit WLAN verbinden';

  @override
  String get scanNext => 'Nächsten scannen';

  @override
  String get flash => 'Blitz';

  @override
  String get scanImage => 'Bild scannen';

  @override
  String get readyToScan => 'Bereit zum Scannen';

  @override
  String get scanHelp =>
      'Richte die Kamera auf einen QR-Code oder wähle ein Bild aus deiner Galerie.';

  @override
  String get noQrFound => 'In diesem Bild wurde kein QR-Code gefunden.';

  @override
  String get scanningSelectedImage => 'Ausgewähltes Bild wird gescannt...';

  @override
  String get imageSelectionCancelled => 'Bildauswahl abgebrochen.';

  @override
  String get qrFoundInImage => 'QR-Code im Bild gefunden.';

  @override
  String imageScanFailed(Object error) {
    return 'Bild konnte nicht gescannt werden: $error';
  }

  @override
  String get cannotOpenQr =>
      'Diese QR-Daten können nicht automatisch geöffnet werden.';

  @override
  String get wifiSettingsOpened => 'WLAN-Einstellungen geöffnet.';

  @override
  String get wifiSettingsFailed =>
      'WLAN-Einstellungen konnten nicht geöffnet werden.';

  @override
  String get copied => 'Kopiert.';

  @override
  String get scannedDataCopied => 'Gescannte Daten kopiert.';

  @override
  String get generatedEmpty => 'Erstellte QR-Codes erscheinen hier.';

  @override
  String get scannedEmpty => 'Gescannte QR-Codes erscheinen hier.';

  @override
  String generatedAt(Object time) {
    return 'Gespeichert $time';
  }

  @override
  String get qrType => 'QR-Typ';

  @override
  String get fileType => 'Dateityp';

  @override
  String get document => 'Dokument';

  @override
  String get image => 'Bild';

  @override
  String get video => 'Video';

  @override
  String get anyFile => 'Beliebige Datei';

  @override
  String get pickUploadCreate => 'Auswählen, hochladen und erstellen';

  @override
  String get uploading => 'Wird hochgeladen...';

  @override
  String get generate => 'Generieren';

  @override
  String get headerDescription =>
      'Erstelle Codes für Text, Links, Kontakte, WLAN, Nachrichten, Anrufe und hochgeladene Dateien.';

  @override
  String get fileUploaded => 'Datei hochgeladen und QR erstellt.';

  @override
  String uploadFailed(Object error) {
    return 'Upload fehlgeschlagen: $error';
  }

  @override
  String get qrDataCopied => 'QR-Daten kopiert.';

  @override
  String get qrSaved => 'QR in der Galerie gespeichert.';

  @override
  String exportFailed(Object error) {
    return 'QR konnte nicht exportiert werden: $error';
  }

  @override
  String get text => 'Text';

  @override
  String get website => 'Website';

  @override
  String get email => 'E-Mail';

  @override
  String get phone => 'Telefon';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => 'Kontakt';

  @override
  String get fileLink => 'Dateilink';

  @override
  String get websiteUrl => 'Website-URL';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get networkName => 'Netzwerkname';

  @override
  String get fullName => 'Vollständiger Name';

  @override
  String get file => 'Datei';

  @override
  String get subject => 'Betreff';

  @override
  String get message => 'Nachricht';

  @override
  String get password => 'Passwort';

  @override
  String get security => 'Sicherheit';

  @override
  String get hidden => 'Ausgeblendet';

  @override
  String get noSecurity => 'Keine';

  @override
  String get organization => 'Organisation';

  @override
  String get required => 'Erforderlich';

  @override
  String get validEmail => 'Gib eine gültige E-Mail-Adresse ein';

  @override
  String get websiteLink => 'Weblink';

  @override
  String get emailAddressTitle => 'E-Mail-Adresse';

  @override
  String get phoneNumberTitle => 'Telefonnummer';

  @override
  String get smsMessage => 'SMS-Nachricht';

  @override
  String get wifiNetwork => 'WLAN-Netzwerk';

  @override
  String get contactCard => 'Kontaktkarte';

  @override
  String get textContent => 'Textinhalt';

  @override
  String get unknownQr => 'QR-Inhalt';

  @override
  String get ssid => 'Netzwerk';

  @override
  String get wifiPassword => 'Passwort';

  @override
  String get wifiSecurity => 'Sicherheit';

  @override
  String get wifiHidden => 'Ausgeblendetes Netzwerk';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get noPassword => 'Kein Passwort';

  @override
  String get rawData => 'Rohdaten';

  @override
  String get links => 'Links';

  @override
  String get wifiNetworks => 'WLAN-Netzwerke';

  @override
  String get contacts => 'Kontakte';

  @override
  String get messages => 'Nachrichten';

  @override
  String get calls => 'Anrufe';

  @override
  String get emails => 'E-Mails';

  @override
  String get texts => 'Texte';

  @override
  String get files => 'Dateien';

  @override
  String get other => 'Andere';
}
