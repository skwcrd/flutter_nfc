import CoreNFC
import Flutter

internal class Felica: NSObject {
    private let tagManager: TagManager

    public init(_ tagManager: TagManager) {
        self.tagManager = tagManager
    }

    @available(iOS 13.0, *)
    public func handle(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        switch arguments["method"] {
        case "polling": polling(arguments, result: result)
        case "requestResponse": requestResponse(arguments, result: result)
        case "requestSystemCode": requestSystemCode(arguments, result: result)
        case "requestService": requestService(arguments, result: result)
        case "requestServiceV2": requestServiceV2(arguments, result: result)
        case "readWithoutEncryption": readWithoutEncryption(arguments, result: result)
        case "writeWithoutEncryption": writeWithoutEncryption(arguments, result: result)
        case "requestSpecificationVersion": requestSpecificationVersion(arguments, result: result)
        case "resetMode": resetMode(arguments, result: result)
        case "sendCommand": sendCommand(arguments, result: result)
        default: result(FlutterMethodNotImplemented)
        }
    }

    @available(iOS 13.0, *)
    private func Polling(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            let systemCode = (arguments["systemCode"] as! FlutterStandardTypedData).data
            let requestCode = PollingRequestCode(
                rawValue: arguments["requestCode"] as! Int)!
            let timeSlot = PollingTimeSlot(
                rawValue: arguments["timeSlot"] as! Int)!

            tag.polling(systemCode: systemCode, requestCode: requestCode, timeSlot: timeSlot) { manufacturerParameter, requestData, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "manufacturerParameter": manufacturerParameter,
                        "requestData": requestData,
                    ])
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func RequestResponse(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            tag.requestResponse { mode, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result(mode)
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func RequestSystemCode(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            tag.requestSystemCode { systemCodeList, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result(systemCodeList)
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func RequestService(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            let nodeCodeList = (arguments["nodeCodeList"] as! [FlutterStandardTypedData]).map { $0.data }

            tag.requestService(nodeCodeList: nodeCodeList) { nodeKeyVersionList, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result(nodeKeyVersionList)
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func RequestServiceV2(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            let nodeCodeList = (arguments["nodeCodeList"] as! [FlutterStandardTypedData]).map { $0.data }

            tag.requestServiceV2(nodeCodeList: nodeCodeList) { statusFlag1, statusFlag2, encryptionIdentifier, nodeKeyVersionListAes, nodeKeyVersionListDes, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "statusFlag1": statusFlag1,
                        "statusFlag2": statusFlag2,
                        "encryptionIdentifier": encryptionIdentifier.rawValue,
                        "nodeKeyVersionListAes": nodeKeyVersionListAes,
                        "nodeKeyVersionListDes": nodeKeyVersionListDes,
                    ])
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func ReadWithoutEncryption(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            let serviceCodeList = (arguments["serviceCodeList"] as! [FlutterStandardTypedData]).map { $0.data }
            let blockList = (arguments["blockList"] as! [FlutterStandardTypedData]).map { $0.data }

            tag.readWithoutEncryption(serviceCodeList: serviceCodeList, blockList: blockList) { statusFlag1, statusFlag2, blockData, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "statusFlag1": statusFlag1,
                        "statusFlag2": statusFlag2,
                        "blockData": blockData,
                    ])
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func WriteWithoutEncryption(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            let serviceCodeList = (arguments["serviceCodeList"] as! [FlutterStandardTypedData]).map { $0.data }
            let blockList = (arguments["blockList"] as! [FlutterStandardTypedData]).map { $0.data }
            let blockData = (arguments["blockData"] as! [FlutterStandardTypedData]).map { $0.data }

            tag.writeWithoutEncryption(serviceCodeList: serviceCodeList, blockList: blockList, blockData: blockData) { statusFlag1, statusFlag2, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "statusFlag1": statusFlag1,
                        "statusFlag2": statusFlag2,
                    ])
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func RequestSpecificationVersion(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            tag.requestSpecificationVersion { statusFlag1, statusFlag2, basicVersion, optionVersion, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "statusFlag1": statusFlag1,
                        "statusFlag2": statusFlag2,
                        "basicVersion": basicVersion,
                        "optionVersion": optionVersion,
                    ])
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func ResetMode(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            tag.resetMode { statusFlag1, statusFlag2, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result([
                        "statusFlag1": statusFlag1,
                        "statusFlag2": statusFlag2,
                    ])
                }
            }
        }
    }

    @available(iOS 13.0, *)
    private func sendCommand(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCFeliCaTag.self, arguments, result) { tag in
            let commandPacket = (arguments["commandPacket"] as! FlutterStandardTypedData).data

            tag.sendFeliCaCommand(commandPacket: commandPacket) { data, error in
                if let error = error {
                    result(getFlutterError(error))
                } else {
                    result(data)
                }
            }
        }
    }
}