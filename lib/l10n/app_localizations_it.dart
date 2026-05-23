// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Studio QR';

  @override
  String get create => 'Crea';

  @override
  String get scan => 'Scansiona';

  @override
  String get history => 'Cronologia';

  @override
  String get created => 'Creati';

  @override
  String get scanned => 'Scansionati';

  @override
  String get settings => 'Impostazioni';

  @override
  String get language => 'Lingua';

  @override
  String get systemLanguage => 'Lingua del dispositivo';

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
  String get copy => 'Copia';

  @override
  String get copyData => 'Copia dati';

  @override
  String get copyQrData => 'Copia dati QR';

  @override
  String get clear => 'Cancella';

  @override
  String get delete => 'Elimina';

  @override
  String get save => 'Salva';

  @override
  String get share => 'Condividi';

  @override
  String get open => 'Apri';

  @override
  String get openLink => 'Apri link';

  @override
  String get connectWifi => 'Connetti Wi-Fi';

  @override
  String get scanNext => 'Scansiona successivo';

  @override
  String get flash => 'Flash';

  @override
  String get scanImage => 'Scansiona immagine';

  @override
  String get readyToScan => 'Pronto per la scansione';

  @override
  String get scanHelp =>
      'Punta la fotocamera su un codice QR o scegli un’immagine dalla galleria.';

  @override
  String get noQrFound => 'Nessun codice QR trovato in questa immagine.';

  @override
  String get scanningSelectedImage => 'Scansione dell’immagine selezionata...';

  @override
  String get imageSelectionCancelled => 'Selezione immagine annullata.';

  @override
  String get qrFoundInImage => 'Codice QR trovato nell’immagine.';

  @override
  String imageScanFailed(Object error) {
    return 'Impossibile scansionare l’immagine: $error';
  }

  @override
  String get cannotOpenQr =>
      'Questi dati QR non possono essere aperti automaticamente.';

  @override
  String get wifiSettingsOpened => 'Impostazioni Wi-Fi aperte.';

  @override
  String get wifiSettingsFailed => 'Impossibile aprire le impostazioni Wi-Fi.';

  @override
  String get copied => 'Copiato.';

  @override
  String get scannedDataCopied => 'Dati scansionati copiati.';

  @override
  String get generatedEmpty => 'I codici QR generati appariranno qui.';

  @override
  String get scannedEmpty => 'I codici QR scansionati appariranno qui.';

  @override
  String generatedAt(Object time) {
    return 'Salvato $time';
  }

  @override
  String get qrType => 'Tipo di QR';

  @override
  String get fileType => 'Tipo di file';

  @override
  String get document => 'Documento';

  @override
  String get image => 'Immagine';

  @override
  String get video => 'Video';

  @override
  String get anyFile => 'Qualsiasi file';

  @override
  String get pickUploadCreate => 'Scegli, carica e crea';

  @override
  String get uploading => 'Caricamento...';

  @override
  String get generate => 'Genera';

  @override
  String get headerDescription =>
      'Crea codici per testo, link, contatti, Wi-Fi, messaggi, chiamate e file caricati.';

  @override
  String get fileUploaded => 'File caricato e QR creato.';

  @override
  String uploadFailed(Object error) {
    return 'Caricamento non riuscito: $error';
  }

  @override
  String get qrDataCopied => 'Dati QR copiati.';

  @override
  String get qrSaved => 'QR salvato nella galleria.';

  @override
  String exportFailed(Object error) {
    return 'Impossibile esportare il QR: $error';
  }

  @override
  String get text => 'Testo';

  @override
  String get website => 'Sito web';

  @override
  String get email => 'E-mail';

  @override
  String get phone => 'Telefono';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => 'Contatto';

  @override
  String get fileLink => 'Link file';

  @override
  String get websiteUrl => 'URL sito web';

  @override
  String get emailAddress => 'Indirizzo e-mail';

  @override
  String get phoneNumber => 'Numero di telefono';

  @override
  String get networkName => 'Nome rete';

  @override
  String get fullName => 'Nome completo';

  @override
  String get file => 'File';

  @override
  String get subject => 'Oggetto';

  @override
  String get message => 'Messaggio';

  @override
  String get password => 'Password';

  @override
  String get security => 'Sicurezza';

  @override
  String get hidden => 'Nascosta';

  @override
  String get noSecurity => 'Nessuna';

  @override
  String get organization => 'Organizzazione';

  @override
  String get required => 'Obbligatorio';

  @override
  String get validEmail => 'Inserisci un indirizzo e-mail valido';

  @override
  String get websiteLink => 'Link web';

  @override
  String get emailAddressTitle => 'Indirizzo e-mail';

  @override
  String get phoneNumberTitle => 'Numero di telefono';

  @override
  String get smsMessage => 'Messaggio SMS';

  @override
  String get wifiNetwork => 'Rete Wi-Fi';

  @override
  String get contactCard => 'Scheda contatto';

  @override
  String get textContent => 'Contenuto testo';

  @override
  String get unknownQr => 'Contenuto QR';

  @override
  String get ssid => 'Rete';

  @override
  String get wifiPassword => 'Password';

  @override
  String get wifiSecurity => 'Sicurezza';

  @override
  String get wifiHidden => 'Rete nascosta';

  @override
  String get yes => 'Sì';

  @override
  String get no => 'No';

  @override
  String get noPassword => 'Nessuna password';

  @override
  String get rawData => 'Dati grezzi';

  @override
  String get links => 'Link';

  @override
  String get wifiNetworks => 'Reti Wi-Fi';

  @override
  String get contacts => 'Contatti';

  @override
  String get messages => 'Messaggi';

  @override
  String get calls => 'Chiamate';

  @override
  String get emails => 'E-mail';

  @override
  String get texts => 'Testi';

  @override
  String get files => 'File';

  @override
  String get other => 'Altro';
}
