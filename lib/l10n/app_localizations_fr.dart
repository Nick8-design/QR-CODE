// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Studio QR';

  @override
  String get create => 'Créer';

  @override
  String get scan => 'Scanner';

  @override
  String get history => 'Historique';

  @override
  String get created => 'Créés';

  @override
  String get scanned => 'Scannés';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get systemLanguage => 'Langue de l’appareil';

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
  String get copy => 'Copier';

  @override
  String get copyData => 'Copier les données';

  @override
  String get copyQrData => 'Copier les données QR';

  @override
  String get clear => 'Effacer';

  @override
  String get delete => 'Supprimer';

  @override
  String get save => 'Enregistrer';

  @override
  String get share => 'Partager';

  @override
  String get open => 'Ouvrir';

  @override
  String get openLink => 'Ouvrir le lien';

  @override
  String get connectWifi => 'Se connecter au Wi-Fi';

  @override
  String get scanNext => 'Scanner le suivant';

  @override
  String get flash => 'Flash';

  @override
  String get scanImage => 'Scanner une image';

  @override
  String get readyToScan => 'Prêt à scanner';

  @override
  String get scanHelp =>
      'Pointez la caméra vers un code QR ou choisissez une image dans votre galerie.';

  @override
  String get noQrFound => 'Aucun code QR trouvé dans cette image.';

  @override
  String get scanningSelectedImage => 'Analyse de l’image sélectionnée...';

  @override
  String get imageSelectionCancelled => 'Sélection d’image annulée.';

  @override
  String get qrFoundInImage => 'Code QR trouvé dans l’image.';

  @override
  String imageScanFailed(Object error) {
    return 'Impossible de scanner l’image : $error';
  }

  @override
  String get cannotOpenQr =>
      'Ces données QR ne peuvent pas être ouvertes automatiquement.';

  @override
  String get wifiSettingsOpened => 'Paramètres Wi-Fi ouverts.';

  @override
  String get wifiSettingsFailed => 'Impossible d’ouvrir les paramètres Wi-Fi.';

  @override
  String get copied => 'Copié.';

  @override
  String get scannedDataCopied => 'Données scannées copiées.';

  @override
  String get generatedEmpty => 'Les codes QR générés apparaîtront ici.';

  @override
  String get scannedEmpty => 'Les codes QR scannés apparaîtront ici.';

  @override
  String generatedAt(Object time) {
    return 'Enregistré $time';
  }

  @override
  String get qrType => 'Type de QR';

  @override
  String get fileType => 'Type de fichier';

  @override
  String get document => 'Document';

  @override
  String get image => 'Image';

  @override
  String get video => 'Vidéo';

  @override
  String get anyFile => 'Tout fichier';

  @override
  String get pickUploadCreate => 'Choisir, téléverser et créer';

  @override
  String get uploading => 'Téléversement...';

  @override
  String get generate => 'Générer';

  @override
  String get headerDescription =>
      'Créez des codes pour du texte, des liens, des contacts, le Wi-Fi, des messages, des appels et des fichiers téléversés.';

  @override
  String get fileUploaded => 'Fichier téléversé et QR créé.';

  @override
  String uploadFailed(Object error) {
    return 'Échec du téléversement : $error';
  }

  @override
  String get qrDataCopied => 'Données QR copiées.';

  @override
  String get qrSaved => 'QR enregistré dans la galerie.';

  @override
  String exportFailed(Object error) {
    return 'Impossible d’exporter le QR : $error';
  }

  @override
  String get text => 'Texte';

  @override
  String get website => 'Site web';

  @override
  String get email => 'E-mail';

  @override
  String get phone => 'Téléphone';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => 'Contact';

  @override
  String get fileLink => 'Lien de fichier';

  @override
  String get websiteUrl => 'URL du site web';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get networkName => 'Nom du réseau';

  @override
  String get fullName => 'Nom complet';

  @override
  String get file => 'Fichier';

  @override
  String get subject => 'Sujet';

  @override
  String get message => 'Message';

  @override
  String get password => 'Mot de passe';

  @override
  String get security => 'Sécurité';

  @override
  String get hidden => 'Masqué';

  @override
  String get noSecurity => 'Aucune';

  @override
  String get organization => 'Organisation';

  @override
  String get required => 'Obligatoire';

  @override
  String get validEmail => 'Entrez une adresse e-mail valide';

  @override
  String get websiteLink => 'Lien web';

  @override
  String get emailAddressTitle => 'Adresse e-mail';

  @override
  String get phoneNumberTitle => 'Numéro de téléphone';

  @override
  String get smsMessage => 'Message SMS';

  @override
  String get wifiNetwork => 'Réseau Wi-Fi';

  @override
  String get contactCard => 'Fiche contact';

  @override
  String get textContent => 'Contenu texte';

  @override
  String get unknownQr => 'Contenu QR';

  @override
  String get ssid => 'Réseau';

  @override
  String get wifiPassword => 'Mot de passe';

  @override
  String get wifiSecurity => 'Sécurité';

  @override
  String get wifiHidden => 'Réseau masqué';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get noPassword => 'Aucun mot de passe';

  @override
  String get rawData => 'Données brutes';

  @override
  String get links => 'Liens';

  @override
  String get wifiNetworks => 'Réseaux Wi-Fi';

  @override
  String get contacts => 'Contacts';

  @override
  String get messages => 'Messages';

  @override
  String get calls => 'Appels';

  @override
  String get emails => 'E-mails';

  @override
  String get texts => 'Textes';

  @override
  String get files => 'Fichiers';

  @override
  String get other => 'Autre';
}
