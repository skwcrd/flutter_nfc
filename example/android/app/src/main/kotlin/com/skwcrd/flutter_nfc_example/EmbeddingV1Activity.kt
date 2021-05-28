package com.skwcrd.flutter_nfc_example

import android.os.Bundle
import io.flutter.app.FlutterActivity

import dev.flutter.plugins.integration_test.IntegrationTestPlugin
import com.skwcrd.flutter_nfc.FlutterNfcPlugin

class EmbeddingV1Activity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        IntegrationTestPlugin.registerWith(
            registrarFor("dev.flutter.plugins.integration_test.IntegrationTestPlugin"))
        FlutterNfcPlugin.registerWith(
            registrarFor("com.skwcrd.flutter_nfc.FlutterNfcPlugin"))
    }
}