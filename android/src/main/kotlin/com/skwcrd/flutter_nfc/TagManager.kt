package com.skwcrd.flutter_nfc

import java.lang.Exception
import java.io.IOException

//import android.app.Activity

import android.nfc.Tag
import android.nfc.NdefRecord
import android.nfc.NdefMessage

import android.nfc.tech.Ndef
import android.nfc.tech.NfcA
import android.nfc.tech.NfcB
import android.nfc.tech.NfcF
import android.nfc.tech.NfcV
import android.nfc.tech.IsoDep
import android.nfc.tech.MifareClassic
import android.nfc.tech.MifareUltralight
import android.nfc.tech.TagTechnology

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

class TagManager/*(private val activity: Activity)*/ {
    private val tags: MutableMap<String, Tag> = mutableMapOf()
    private var connectedTech: TagTechnology? = null

    companion object {
        @JvmStatic
        fun getNdefMessageMap(message: NdefMessage?): Map<String, Any?>? {
            if ( message == null ) { return null }

            return mapOf(
                "records" to message.records.map {
                    mapOf(
                        "identifier" to it.id,
                        "type" to it.type,
                        "typeNameFormat" to it.tnf,
                        "payload" to it.payload)
                }.toList())
        }

        @JvmStatic
        fun getNdefMessage(data: Map<String, Any?>): NdefMessage {
            val records = (data["records"] as List<*>).filterIsInstance<Map<String, Any?>>()

            return NdefMessage(records.map {
                NdefRecord(
                    (it["typeNameFormat"] as Int).toShort(),
                    it["type"] as ByteArray,
                    it["identifier"] as? ByteArray,
                    it["payload"] as ByteArray
                )
            }.toTypedArray())
        }
    }

    fun getTagMap(tag: Tag): Map<String, Any?> {
        val handle = tag.id.toString()
        val data = mutableMapOf<String, Any?>()

        tags[handle] = tag
        data["handle"] = handle

        for ( tech in tag.techList ) {
            data[tech.split(".").last()] = when (tech) {
                NfcA::class.java.name -> NfcA.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "atqa" to it.atqa,
                        "maxTransceiveLength" to it.maxTransceiveLength,
                        "sak" to it.sak,
                        "timeout" to it.timeout)
                }
                NfcB::class.java.name -> NfcB.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "applicationData" to it.applicationData,
                        "maxTransceiveLength" to it.maxTransceiveLength,
                        "protocolInfo" to it.protocolInfo)
                }
                NfcF::class.java.name -> NfcF.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "manufacturer" to it.manufacturer,
                        "maxTransceiveLength" to it.maxTransceiveLength,
                        "systemCode" to it.systemCode,
                        "timeout" to it.timeout)
                }
                NfcV::class.java.name -> NfcV.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "dsfId" to it.dsfId,
                        "responseFlags" to it.responseFlags,
                        "maxTransceiveLength" to it.maxTransceiveLength)
                }
                IsoDep::class.java.name -> IsoDep.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "hiLayerResponse" to it.hiLayerResponse,
                        "historicalBytes" to it.historicalBytes,
                        "isExtendedLengthApduSupported" to it.isExtendedLengthApduSupported,
                        "maxTransceiveLength" to it.maxTransceiveLength,
                        "timeout" to it.timeout)
                }
                MifareClassic::class.java.name -> MifareClassic.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "blockCount" to it.blockCount,
                        "maxTransceiveLength" to it.maxTransceiveLength,
                        "sectorCount" to it.sectorCount,
                        "size" to it.size,
                        "timeout" to it.timeout,
                        "type" to it.type)
                }
                MifareUltralight::class.java.name -> MifareUltralight.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "maxTransceiveLength" to it.maxTransceiveLength,
                        "timeout" to it.timeout,
                        "type" to it.type)
                }
                Ndef::class.java.name -> Ndef.get(tag).let {
                    mapOf(
                        "identifier" to tag.id,
                        "isWritable" to it.isWritable,
                        "maxSize" to it.maxSize,
                        "canMakeReadOnly" to it.canMakeReadOnly(),
                        "cachedMessage" to getNdefMessageMap(it.cachedNdefMessage),
                        "type" to it.type)
                }
                // NdefFormatable or NfcBarcode
                else -> mapOf(
                    "identifier" to tag.id)
            }
        }

        return data
    }

    @Synchronized
    fun <T: TagTechnology> tagHandler(
        call: MethodCall,
        result: Result,
        getMethod: (Tag) -> T?,
        callback: (T) -> Unit) {
        val tag = tags[call.argument<String>("handle")!!] ?: run {
            result.error(
                "invalid_parameter",
                "Tag is not found",
                null)
            return
        }

        val tech = getMethod(tag) ?: run {
            result.error(
                "invalid_parameter",
                "Tech is not supported",
                null)
            return
        }

        try {
            forceConnect(tech)
            callback(tech)
        } catch (e: Exception) {
            result.error(
                "io_exception",
                e.localizedMessage,
                null)
        }
    }

    fun disposeTag(call: MethodCall, result: Result) {
        val tag = tags.remove(call.argument<String>("handle")!!) ?: run {
            result.success(null)
            return
        }

        val tech = connectedTech ?: run {
            result.success(null)
            return
        }

        if ( (tech.tag == tag) && tech.isConnected ) {
            try { tech.close() } catch (e: IOException) { /* no op */ }
        }

        connectedTech = null

        result.success(null)
    }

    fun dispose() {
        tags.clear()
        connectedTech = null
    }

    @Throws(IOException::class)
    private fun forceConnect(tech: TagTechnology) {
        connectedTech?.let {
            if ( (it.tag == tech.tag) && (it::class.java.name == tech::class.java.name) ) {
                return
            }

            try { tech.close() } catch (e: IOException) { /* no op */ }

            tech.connect()
            connectedTech = tech
        } ?: run {
            tech.connect()
            connectedTech = tech
        }
    }
}