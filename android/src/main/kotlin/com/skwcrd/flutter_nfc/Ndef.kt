package com.skwcrd.flutter_nfc

//import android.app.Activity

import android.nfc.tech.Ndef
import android.nfc.tech.NdefFormatable

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

class Ndef(
//        private val activity: Activity,
        private val tagManager: TagManager) {
    fun method(call: MethodCall, result: Result) {
        when (call.argument<String>("method")!!) {
            "read" -> ndefRead(call, result)
            "write" -> ndefWrite(call, result)
            "writeLock" -> ndefWriteLock(call, result)
            else -> result.notImplemented()
        }
    }

    fun formatable(call: MethodCall, result: Result) {
        when (call.argument<String>("method")!!) {
            "format" -> ndefFormatableFormat(call, result)
            "formatReadOnly" -> ndefFormatableFormatReadOnly(call, result)
            else -> result.notImplemented()
        }
    }

    private fun ndefRead(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { Ndef.get(it) }) {
            val message = it.ndefMessage

            result.success(
                TagManager.getNdefMessageMap(message))
        }
    }

    private fun ndefWrite(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { Ndef.get(it) }) {
            val message = TagManager.getNdefMessage(
                call.argument<Map<String, Any?>>("message")!!)

            it.writeNdefMessage(message)

            result.success(null)
        }
    }

    private fun ndefWriteLock(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { Ndef.get(it) }) {
            it.makeReadOnly()

            result.success(null)
        }
    }

    private fun ndefFormatableFormat(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { NdefFormatable.get(it) }) {
            val message = TagManager.getNdefMessage(
                call.argument<Map<String, Any?>>("message")!!)

            it.format(message)

            result.success(null)
        }
    }

    private fun ndefFormatableFormatReadOnly(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { NdefFormatable.get(it) }) {
            val message = TagManager.getNdefMessage(
                call.argument<Map<String, Any?>>("message")!!)

            it.formatReadOnly(message)

            result.success(null)
        }
    }
}