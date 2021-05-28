package com.skwcrd.flutter_nfc

//import android.app.Activity

import android.nfc.tech.NfcA
import android.nfc.tech.NfcB
import android.nfc.tech.NfcF
import android.nfc.tech.NfcV
import android.nfc.tech.IsoDep

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

class NfcTransceiver(
//        private val activity: Activity,
        private val tagManager: TagManager) {
    fun method(call: MethodCall, result: Result) {
        when (call.argument<String>("type")!!) {
            "NfcA" -> nfcATransceive(call, result)
            "NfcB" -> nfcBTransceive(call, result)
            "NfcF" -> nfcFTransceive(call, result)
            "NfcV" -> nfcVTransceive(call, result)
            "IsoDep" -> isoDepTransceive(call, result)
            else -> result.notImplemented()
        }
    }

    private fun nfcATransceive(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { NfcA.get(it) }) {
            val data = call.argument<ByteArray>("data")!!
            val timeout = call.argument<Int>("timeout")!!

            it.timeout = timeout

            result.success(
                it.transceive(data))
        }
    }

    private fun nfcBTransceive(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { NfcB.get(it) }) {
            val data = call.argument<ByteArray>("data")!!

            result.success(
                it.transceive(data))
        }
    }

    private fun nfcFTransceive(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { NfcF.get(it) }) {
            val data = call.argument<ByteArray>("data")!!
            val timeout = call.argument<Int>("timeout")!!

            it.timeout = timeout

            result.success(
                it.transceive(data))
        }
    }

    private fun nfcVTransceive(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { NfcV.get(it) }) {
            val data = call.argument<ByteArray>("data")!!

            result.success(
                it.transceive(data))
        }
    }

    private fun isoDepTransceive(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { IsoDep.get(it) }) {
            val data = call.argument<ByteArray>("data")!!
            val timeout = call.argument<Int>("timeout")!!

            it.timeout = timeout

            result.success(
                it.transceive(data))
        }
    }
}