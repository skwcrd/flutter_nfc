import CoreNFC
import Flutter

internal class TagManager: NSObject {
    @available(iOS 13.0, *)
    private lazy var tags: [String: NFCNDEFTag] = [:]

    @available(iOS 13.0, *)
    public func tagHandler<T>(_ dump: T.Type, _ arguments: [String: Any?], _ result: FlutterResult, callback: ((T) -> Void)) {
        if let tag = tags[arguments["handle"] as! String] as? T {
            callback(tag)
        } else {
            result(
                FlutterError(
                    code: "invalid_parameter",
                    message: "Tag is not found",
                    details: nil))
        }
    }

    @available(iOS 13.0, *)
    public func disposeTag(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        tags.removeValue(
            forKey: arguments["handle"] as! String)
        result(nil)
    }

    @available(iOS 11.0, *)
    public func getNDEFMessageMap(_ arg: NFCNDEFMessage) -> [String: Any?] {
        return [
            "records": arg.records.map {
                [
                    "typeNameFormat": $0.typeNameFormat.rawValue,
                    "type": $0.type,
                    "identifier": $0.identifier,
                    "payload": $0.payload,
                ]
            }
        ]
    }

    @available(iOS 13.0, *)
    public func getNFCTagMap(_ arg: NFCTag, _ completionHandler: @escaping (NFCNDEFTag, [String: Any?], Error?) -> Void) {
        switch (arg) {
        case .feliCa(let tag):
            getNDEFTagMap(tag) { data, error in completionHandler(tag, data, error) }
        case .miFare(let tag):
            getNDEFTagMap(tag) { data, error in completionHandler(tag, data, error) }
        case .iso7816(let tag):
            getNDEFTagMap(tag) { data, error in completionHandler(tag, data, error) }
        case .iso15693(let tag):
            getNDEFTagMap(tag) { data, error in completionHandler(tag, data, error) }
        @unknown default:
            print("Unknown tag cannot be serialized")
        }
    }

    @available(iOS 13.0, *)
    private func getNDEFTagMap(_ arg: NFCNDEFTag, _ completionHandler: @escaping ([String: Any?], Error?) -> Void) {
        let handle = NSUUID().uuidString

        self.tags[handle] = arg

        var data = getTagMap(arg)

        data["handle"] = handle

        arg.queryNDEFStatus { status, capacity, error in
            if let error = error {
                completionHandler(data, error)
                return
            }

            if status == .notSupported {
                completionHandler(data, nil)
                return
            }

            var ndefData: [String: Any?] = [
                "isWritable": (status == .readWrite),
                "maxSize": capacity,
            ]

            arg.readNDEF { message, _ in
                if let message = message {
                    ndefData["cachedMessage"] = getNDEFMessageMap(message)
                }

                data["Ndef"] = ndefData

                var techList = data["techList"] as! [String]
                techList.append("Ndef")

                data["techList"] = techList

                completionHandler(data, nil)
            }
        }
    }

    @available(iOS 13.0, *)
    private func getTagMap(_ arg: NFCNDEFTag) -> [String: [String: Any?]] {
        if let arg = arg as? NFCMiFareTag {
            return [
                "techList": [ "Mifare" ],
                "Mifare": [
                    "historicalBytes": arg.historicalBytes,
                    "identifier": arg.identifier,
                    "mifareFamily": arg.mifareFamily.rawValue
                ]
            ]
        } else if let arg = arg as? NFCFeliCaTag {
            return [
                "techList": [ "Felica" ],
                "Felica": [
                    "currentIDm": arg.currentIDm,
                    "currentSystemCode": arg.currentSystemCode
                ]
            ]
        } else if let arg = arg as? NFCISO7816Tag {
            return [
                "techList": [ "Iso7816" ],
                "Iso7816": [
                    "applicationData": arg.applicationData,
                    "historicalBytes": arg.historicalBytes,
                    "identifier": arg.identifier,
                    "initialSelectedAID": arg.initialSelectedAID,
                    "proprietaryApplicationDataCoding": arg.proprietaryApplicationDataCoding
                ]
            ]
        } else if let arg = arg as? NFCISO15693Tag {
            return [
                "techList": [ "Iso15693" ],
                "Iso15693": [
                    "icManufacturerCode": arg.icManufacturerCode,
                    "icSerialNumber": arg.icSerialNumber,
                    "identifier": arg.identifier
                ]
            ]
        } else {
            return [:]
        }
    }
}