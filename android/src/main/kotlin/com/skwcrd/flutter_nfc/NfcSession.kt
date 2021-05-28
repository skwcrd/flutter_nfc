package com.skwcrd.flutter_nfc

import android.app.Activity
import android.content.Context

import android.nfc.Tag
import android.nfc.NfcAdapter

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class NfcSession(
    private val activity: Activity,
    private val channel : MethodChannel,
    private val tagManager: TagManager,
): NfcAdapter.ReaderCallback {
    private var adapter: NfcAdapter? = null

    override fun onTagDiscovered(tag: Tag) {
        activity.runOnUiThread {
            channel.invokeMethod(
                "onTagDiscovered",
                tagManager.getTagMap(tag).toMutableMap())
        }
    }

    fun init(content: Context) {
        adapter = NfcAdapter.getDefaultAdapter(content)
    }

    fun isAvailable(/*call: MethodCall, */result: Result) {
        result.success(
            adapter?.isEnabled ?: false)
    }

    fun startSession(call: MethodCall, result: Result) {
        val adapter = adapter ?: run {
            result.error(
                "unavailable",
                "NFC is not available for device.",
                null)
            return
        }

        val pollingOption = call.argument<List<String>>("pollingOption")!!

        adapter.enableReaderMode(activity, this, getFlags(pollingOption), null)
        result.success(null)
    }

    fun stopSession(/*call: MethodCall, */result: Result) {
        val adapter = adapter ?: run {
            result.error(
                "unavailable",
                "NFC is not available for device.",
                null)
            return
        }

        adapter.disableReaderMode(activity)
        result.success(null)
    }

    fun dispose() {
        adapter?.disableReaderMode(activity)
        adapter = null
    }

    private fun getFlags(
        options: List<String> = listOf(
            "iso14443",
            "iso15693",
            "iso18092")
    ): Int {
        var flags = 0

        for ( option in options ) {
            when {
                option.contains("iso14443") -> { // iso14443
                    flags = flags or NfcAdapter.FLAG_READER_NFC_A or NfcAdapter.FLAG_READER_NFC_B
                }
                option.contains("iso15693") -> { // iso15693
                    flags = flags or NfcAdapter.FLAG_READER_NFC_V
                }
                option.contains("iso18092") -> { // iso18092
                    flags = flags or NfcAdapter.FLAG_READER_NFC_F
                }
            }
        }

        return flags
    }
}