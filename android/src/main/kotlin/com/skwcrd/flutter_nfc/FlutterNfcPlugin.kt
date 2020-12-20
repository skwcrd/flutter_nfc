package com.skwcrd.flutter_nfc

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry.Registrar

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class FlutterNfcPlugin: FlutterPlugin, MethodCallHandler {
    private var channel : MethodChannel? = null

    companion object {
        const val CHANNEL_NAME = "flutter_nfc"

        @JvmStatic
        fun registerWith(@NonNull registrar: Registrar) {
            val plugin = FlutterNfcPlugin()
            plugin.setup(
                    registrar.messenger())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success(
                    "Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
        setup(
                binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {
        tearDown()
    }

    private fun setup(messenger: BinaryMessenger) {
        channel = MethodChannel(
                messenger, CHANNEL_NAME)
        channel!!.setMethodCallHandler(this)
    }

    private fun tearDown() {
        if ( channel != null ) {
            channel!!.setMethodCallHandler(null)
            channel = null
        }
    }
}