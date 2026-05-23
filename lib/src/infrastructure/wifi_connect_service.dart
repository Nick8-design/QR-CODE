import 'package:flutter/services.dart';

class WifiConnectService {
  static const _channel = MethodChannel('qr_studio/wifi');

  Future<bool> openWifiSettings() async {
    final opened = await _channel.invokeMethod<bool>('openWifiSettings');
    return opened ?? false;
  }
}
