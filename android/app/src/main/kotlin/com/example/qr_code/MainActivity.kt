package com.nickdieda.qrstudio

import android.content.ActivityNotFoundException
import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "qr_studio/wifi"
        ).setMethodCallHandler { call, result ->
            if (call.method != "openWifiSettings") {
                result.notImplemented()
                return@setMethodCallHandler
            }

            val opened = try {
                startActivity(Intent(Settings.ACTION_WIFI_SETTINGS))
                true
            } catch (_: ActivityNotFoundException) {
                false
            }
            result.success(opened)
        }
    }
}
