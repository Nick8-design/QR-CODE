// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Estudio QR';

  @override
  String get create => 'Crear';

  @override
  String get scan => 'Escanear';

  @override
  String get history => 'Historial';

  @override
  String get created => 'Creados';

  @override
  String get scanned => 'Escaneados';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma del dispositivo';

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
  String get copyData => 'Copiar datos';

  @override
  String get copyQrData => 'Copiar datos QR';

  @override
  String get clear => 'Limpiar';

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get share => 'Compartir';

  @override
  String get open => 'Abrir';

  @override
  String get openLink => 'Abrir enlace';

  @override
  String get connectWifi => 'Conectar Wi-Fi';

  @override
  String get scanNext => 'Escanear otro';

  @override
  String get flash => 'Flash';

  @override
  String get scanImage => 'Escanear imagen';

  @override
  String get readyToScan => 'Listo para escanear';

  @override
  String get scanHelp =>
      'Apunta la cámara a un código QR o elige una imagen de tu galería.';

  @override
  String get noQrFound => 'No se encontró ningún código QR en esa imagen.';

  @override
  String get scanningSelectedImage => 'Escaneando imagen seleccionada...';

  @override
  String get imageSelectionCancelled => 'Selección de imagen cancelada.';

  @override
  String get qrFoundInImage => 'Código QR encontrado en la imagen.';

  @override
  String imageScanFailed(Object error) {
    return 'No se pudo escanear la imagen: $error';
  }

  @override
  String get cannotOpenQr =>
      'Estos datos QR no se pueden abrir automáticamente.';

  @override
  String get wifiSettingsOpened => 'Ajustes de Wi-Fi abiertos.';

  @override
  String get wifiSettingsFailed => 'No se pudieron abrir los ajustes de Wi-Fi.';

  @override
  String get copied => 'Copiado.';

  @override
  String get scannedDataCopied => 'Datos escaneados copiados.';

  @override
  String get generatedEmpty => 'Los códigos QR generados aparecerán aquí.';

  @override
  String get scannedEmpty => 'Los códigos QR escaneados aparecerán aquí.';

  @override
  String generatedAt(Object time) {
    return 'Guardado $time';
  }

  @override
  String get qrType => 'Tipo de QR';

  @override
  String get fileType => 'Tipo de archivo';

  @override
  String get document => 'Documento';

  @override
  String get image => 'Imagen';

  @override
  String get video => 'Video';

  @override
  String get anyFile => 'Cualquier archivo';

  @override
  String get pickUploadCreate => 'Elegir, subir y crear';

  @override
  String get uploading => 'Subiendo...';

  @override
  String get generate => 'Generar';

  @override
  String get headerDescription =>
      'Crea códigos para texto, enlaces, contactos, Wi-Fi, mensajes, llamadas y archivos subidos.';

  @override
  String get fileUploaded => 'Archivo subido y QR creado.';

  @override
  String uploadFailed(Object error) {
    return 'Error al subir: $error';
  }

  @override
  String get qrDataCopied => 'Datos QR copiados.';

  @override
  String get qrSaved => 'QR guardado en la galería.';

  @override
  String exportFailed(Object error) {
    return 'No se pudo exportar el QR: $error';
  }

  @override
  String get text => 'Texto';

  @override
  String get website => 'Sitio web';

  @override
  String get email => 'Correo';

  @override
  String get phone => 'Teléfono';

  @override
  String get sms => 'SMS';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get contact => 'Contacto';

  @override
  String get fileLink => 'Enlace de archivo';

  @override
  String get websiteUrl => 'URL del sitio web';

  @override
  String get emailAddress => 'Dirección de correo';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get networkName => 'Nombre de red';

  @override
  String get fullName => 'Nombre completo';

  @override
  String get file => 'Archivo';

  @override
  String get subject => 'Asunto';

  @override
  String get message => 'Mensaje';

  @override
  String get password => 'Contraseña';

  @override
  String get security => 'Seguridad';

  @override
  String get hidden => 'Oculta';

  @override
  String get noSecurity => 'Ninguna';

  @override
  String get organization => 'Organización';

  @override
  String get required => 'Obligatorio';

  @override
  String get validEmail => 'Introduce un correo válido';

  @override
  String get websiteLink => 'Enlace web';

  @override
  String get emailAddressTitle => 'Dirección de correo';

  @override
  String get phoneNumberTitle => 'Número de teléfono';

  @override
  String get smsMessage => 'Mensaje SMS';

  @override
  String get wifiNetwork => 'Red Wi-Fi';

  @override
  String get contactCard => 'Tarjeta de contacto';

  @override
  String get textContent => 'Contenido de texto';

  @override
  String get unknownQr => 'Contenido QR';

  @override
  String get ssid => 'Red';

  @override
  String get wifiPassword => 'Contraseña';

  @override
  String get wifiSecurity => 'Seguridad';

  @override
  String get wifiHidden => 'Red oculta';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get noPassword => 'Sin contraseña';

  @override
  String get rawData => 'Datos sin procesar';

  @override
  String get links => 'Enlaces';

  @override
  String get wifiNetworks => 'Redes Wi-Fi';

  @override
  String get contacts => 'Contactos';

  @override
  String get messages => 'Mensajes';

  @override
  String get calls => 'Llamadas';

  @override
  String get emails => 'Correos';

  @override
  String get texts => 'Textos';

  @override
  String get files => 'Archivos';

  @override
  String get other => 'Otro';
}
