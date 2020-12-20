package com.skwcrd.flutter_nfc_example

import android.os.Bundle
import io.flutter.app.FlutterActivity

import dev.flutter.plugins.e2e.E2EPlugin
import com.skwcrd.flutter_nfc.FlutterNfcPlugin

class EmbeddingV1Activity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        E2EPlugin.registerWith(
                registrarFor("dev.flutter.plugins.e2e.E2EPlugin"))
        FlutterNfcPlugin.registerWith(
                registrarFor("com.skwcrd.flutter_nfc.FlutterNfcPlugin"))
    }
}