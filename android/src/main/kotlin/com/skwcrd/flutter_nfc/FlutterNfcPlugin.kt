package com.skwcrd.flutter_nfc

import androidx.annotation.NonNull

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.provider.Settings

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterNfcPlugin: FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {
    private lateinit var activity : Activity
    private lateinit var channel : MethodChannel

    private lateinit var ndef: Ndef
    private lateinit var mifare: Mifare
    private lateinit var transceiver: NfcTransceiver

    private lateinit var session: NfcSession
    private lateinit var tagManager: TagManager

    private var pluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val instance = FlutterNfcPlugin()
            instance.setup(
                registrar.context().applicationContext,
                registrar.activity(),
                registrar.messenger())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "isAvailable" -> session.isAvailable(/*call, */result)
            "openSetting" -> openSetting(/*call, */result)
            "startSession" -> session.startSession(call, result)
            "stopSession" -> session.stopSession(/*call, */result)
            "disposeTag" -> tagManager.disposeTag(call, result)
            "transceive" -> transceiver.method(call, result)
            "Ndef" -> ndef.method(call, result)
            "NdefFormatable" -> ndef.formatable(call, result)
            "MifareClassic" -> mifare.classic(call, result)
            "MifareUltralight" -> mifare.ultralight(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = binding
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        setup(
            pluginBinding!!.applicationContext,
            binding.activity,
            pluginBinding!!.binaryMessenger)
    }

    override fun onDetachedFromActivity() {
        tearDown()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    private fun setup(
            @NonNull context: Context,
            @NonNull activity: Activity,
            @NonNull messenger: BinaryMessenger) {
        this.activity = activity

        channel = MethodChannel(messenger, "plugin.skwcrd.com/flutter_nfc")
        channel.setMethodCallHandler(this)

        tagManager = TagManager(/*activity*/)

        ndef = Ndef(/*activity, */tagManager)
        mifare = Mifare(/*activity, */tagManager)
        transceiver = NfcTransceiver(/*activity, */tagManager)

        session = NfcSession(activity, channel, tagManager)
        session.init(context)
    }

    private fun tearDown() {
        channel.setMethodCallHandler(null)

        session.dispose()
        tagManager.dispose()
    }

    private fun openSetting(/*call: MethodCall, */result: MethodChannel.Result) {
        val intent = Intent()

        intent.action = Settings.ACTION_NFC_SETTINGS
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        activity.applicationContext.startActivity(intent)

        result.success(null)
    }
}