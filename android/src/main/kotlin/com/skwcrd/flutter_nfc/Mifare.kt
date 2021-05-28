package com.skwcrd.flutter_nfc

//import android.app.Activity

import android.nfc.tech.MifareClassic
import android.nfc.tech.MifareUltralight

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

class Mifare(
//        private val activity: Activity,
        private val tagManager: TagManager) {
    fun classic(call: MethodCall, result: Result) {
        when (call.argument<String>("method")!!) {
            "authenticateSectorWithKeyA" -> mifareClassicAuthenticateSectorWithKeyA(call, result)
            "authenticateSectorWithKeyB" -> mifareClassicAuthenticateSectorWithKeyB(call, result)
            "increment" -> mifareClassicIncrement(call, result)
            "decrement" -> mifareClassicDecrement(call, result)
            "readBlock" -> mifareClassicReadBlock(call, result)
            "writeBlock" -> mifareClassicWriteBlock(call, result)
            "restore" -> mifareClassicRestore(call, result)
            "transfer" -> mifareClassicTransfer(call, result)
            "transceive" -> mifareClassicTransceive(call, result)
            else -> result.notImplemented()
        }
    }

    fun ultralight(call: MethodCall, result: Result) {
        when (call.argument<String>("method")!!) {
            "readPages" -> mifareUltralightReadPages(call, result)
            "writePage" -> mifareUltralightWritePage(call, result)
            "transceive" -> mifareUltralightTransceive(call, result)
            else -> result.notImplemented()
        }
    }

    private fun mifareClassicAuthenticateSectorWithKeyA(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val sectorIndex = call.argument<Int>("sectorIndex")!!
            val key = call.argument<ByteArray>("key")!!

            result.success(
                it.authenticateSectorWithKeyA(sectorIndex, key))
        }
    }

    private fun mifareClassicAuthenticateSectorWithKeyB(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val sectorIndex = call.argument<Int>("sectorIndex")!!
            val key = call.argument<ByteArray>("key")!!

            result.success(
                it.authenticateSectorWithKeyB(sectorIndex, key))
        }
    }

    private fun mifareClassicIncrement(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val blockIndex = call.argument<Int>("blockIndex")!!
            val value = call.argument<Int>("value")!!

            it.increment(blockIndex, value)

            result.success(null)
        }
    }

    private fun mifareClassicDecrement(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val blockIndex = call.argument<Int>("blockIndex")!!
            val value = call.argument<Int>("value")!!

            it.decrement(blockIndex, value)

            result.success(null)
        }
    }

    private fun mifareClassicReadBlock(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val blockIndex = call.argument<Int>("blockIndex")!!

            result.success(
                it.readBlock(blockIndex))
        }
    }

    private fun mifareClassicWriteBlock(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val blockIndex = call.argument<Int>("blockIndex")!!
            val data = call.argument<ByteArray>("data")!!

            it.writeBlock(blockIndex, data)

            result.success(null)
        }
    }

    private fun mifareClassicRestore(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val blockIndex = call.argument<Int>("blockIndex")!!

            it.restore(blockIndex)

            result.success(null)
        }
    }

    private fun mifareClassicTransfer(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val blockIndex = call.argument<Int>("blockIndex")!!

            it.transfer(blockIndex)

            result.success(null)
        }
    }

    private fun mifareClassicTransceive(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareClassic.get(it) }) {
            val data = call.argument<ByteArray>("data")!!
            val timeout = call.argument<Int>("timeout")!!

            it.timeout = timeout

            result.success(
                it.transceive(data))
        }
    }

    private fun mifareUltralightReadPages(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareUltralight.get(it) }) {
            val pageOffset = call.argument<Int>("pageOffset")!!

            result.success(
                it.readPages(pageOffset))
        }
    }

    private fun mifareUltralightWritePage(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareUltralight.get(it) }) {
            val pageOffset = call.argument<Int>("pageOffset")!!
            val data = call.argument<ByteArray>("data")!!

            it.writePage(pageOffset, data)

            result.success(null)
        }
    }

    private fun mifareUltralightTransceive(call: MethodCall, result: Result) {
        tagManager.tagHandler(call, result, { MifareUltralight.get(it) }) {
            val data = call.argument<ByteArray>("data")!!
            val timeout = call.argument<Int>("timeout")!!

            it.timeout = timeout

            result.success(
                it.transceive(data))
        }
    }
}