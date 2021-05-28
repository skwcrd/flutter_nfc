import CoreNFC
import Flutter

internal class Ndef: NSObject {
    private let tagManager: TagManager

    public init(_ tagManager: TagManager) {
        self.tagManager = tagManager
    }

    @available(iOS 13.0, *)
    public func handle(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        switch arguments["method"] {
        case "read": read(arguments, result: result)
        case "write": write(arguments, result: result)
        case "writeLock": writeLock(arguments, result: result)
        default: result(FlutterMethodNotImplemented)
        }
    }

    @available(iOS 13.0, *)
    private func read(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCNDEFTag.self, arguments, result) { tag in
            tag.readNDEF { message, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result(
                        (message == nil) ? nil : self.tagManager.getNDEFMessageMap(message!))
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func write(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCNDEFTag.self, arguments, result) { tag in
            let message = getNDEFMessage(
                arguments["message"] as! [String: Any?])

            tag.writeNDEF(message) { error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result(nil)
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func writeLock(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCNDEFTag.self, arguments, result) { tag in
            tag.writeLock { error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result(nil)
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func getNDEFMessage(_ arg: [String: Any?]) -> NFCNDEFMessage {
        return NFCNDEFMessage(
            records: (arg["records"] as! Array<[String: Any?]>).map {
                NFCNDEFPayload(
                    format: NFCTypeNameFormat(
                        rawValue: $0["typeNameFormat"] as! UInt8)!,
                    type: ($0["type"] as! FlutterStandardTypedData).data,
                    identifier: ($0["identifier"] as! FlutterStandardTypedData).data,
                    payload: ($0["payload"] as! FlutterStandardTypedData).data
                )
            })
    }
}