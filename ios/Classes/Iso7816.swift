import CoreNFC
import Flutter

internal class Iso7816: NSObject {
    private let tagManager: TagManager

    public init(_ tagManager: TagManager) {
        self.tagManager = tagManager
    }

    @available(iOS 13.0, *)
    public func handle(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        switch arguments["method"] {
        case "sendCommand": sendCommand(call.arguments as! [String : Any?], result: result)
        case "sendCommandRaw": sendCommandRaw(call.arguments as! [String : Any?], result: result)
        default: result(FlutterMethodNotImplemented)
        }
    }

    @available(iOS 13.0, *)
    private func sendCommand(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO7816Tag.self, arguments, result) { tag in
            let apdu = NFCISO7816APDU(
                instructionClass: arguments["instructionClass"] as! UInt8,
                instructionCode: arguments["instructionCode"] as! UInt8,
                p1Parameter: arguments["p1Parameter"] as! UInt8,
                p2Parameter: arguments["p2Parameter"] as! UInt8,
                data: (arguments["data"] as! FlutterStandardTypedData).data,
                expectedResponseLength: arguments["expectedResponseLength"] as! Int)

            tag.sendCommand(apdu: apdu) { payload, statusWord1, statusWord2, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "payload": payload,
                        "statusWord1": statusWord1,
                        "statusWord2": statusWord2,
                    ])
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func sendCommandRaw(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO7816Tag.self, arguments, result) { tag in
            guard let apdu = NFCISO7816APDU(data: (arguments["data"] as! FlutterStandardTypedData).data) else {
                result(
                    FlutterError(
                        code: "invalid_parameter",
                        message: nil,
                        details: nil))
                return
            }

            tag.sendCommand(apdu: apdu) { payload, statusWord1, statusWord2, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "payload": payload,
                        "statusWord1": statusWord1,
                        "statusWord2": statusWord2,
                    ])
                }
            }
        }
    }
}