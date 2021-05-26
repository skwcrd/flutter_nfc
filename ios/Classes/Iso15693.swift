import CoreNFC
import Flutter

internal class Iso15693: NSObject {
    private let tagManager: TagManager

    public init(_ tagManager: TagManager) {
        self.tagManager = tagManager
    }

    @available(iOS 13.0, *)
    public func handle(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        switch arguments["method"] {
        case "readSingleBlock": readSingleBlock(arguments, result: result)
        case "writeSingleBlock": writeSingleBlock(arguments, result: result)
        case "lockBlock": lockBlock(arguments, result: result)
        case "readMultipleBlocks": readMultipleBlocks(arguments, result: result)
        case "writeMultipleBlocks": writeMultipleBlocks(arguments, result: result)
        case "getMultipleBlockSecurityStatus": getMultipleBlockSecurityStatus(arguments, result: result)
        case "writeAfi": writeAfi(arguments, result: result)
        case "lockAfi": lockAfi(arguments, result: result)
        case "writeDsfId": writeDsfId(arguments, result: result)
        case "lockDsfId": lockDsfId(arguments, result: result)
        case "resetToReady": resetToReady(arguments, result: result)
        case "select": select(arguments, result: result)
        case "stayQuiet": stayQuiet(arguments, result: result)
        case "extendedReadSingleBlock": extendedReadSingleBlock(arguments, result: result)
        case "extendedWriteSingleBlock": extendedWriteSingleBlock(arguments, result: result)
        case "extendedLockBlock": extendedLockBlock(arguments, result: result)
        case "extendedReadMultipleBlocks": extendedReadMultipleBlocks(arguments, result: result)
        case "getSystemInfo": getSystemInfo(arguments, result: result)
        case "customCommand": customCommand(arguments, result: result)
        default: result(FlutterMethodNotImplemented)
        }
    }

    @available(iOS 13.0, *)
    private func readSingleBlock(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! UInt8
        tag.readSingleBlock(requestFlags: requestFlags, blockNumber: blockNumber) { dataBlock, error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(dataBlock)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func writeSingleBlock(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! UInt8
        let dataBlock = (arguments["dataBlock"] as! FlutterStandardTypedData).data
        tag.writeSingleBlock(requestFlags: requestFlags, blockNumber: blockNumber, dataBlock: dataBlock) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func lockBlock(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! UInt8
        tag.lockBlock(requestFlags: requestFlags, blockNumber: blockNumber) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func readMultipleBlocks(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! Int
        let numberOfBlocks = arguments["numberOfBlocks"] as! Int
        tag.readMultipleBlocks(requestFlags: requestFlags, blockRange: NSMakeRange(blockNumber, numberOfBlocks)) { dataBlocks, error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(dataBlocks)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func writeMultipleBlocks(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! Int
        let numberOfBlocks = arguments["numberOfBlocks"] as! Int
        let dataBlocks = (arguments["dataBlocks"] as! [FlutterStandardTypedData]).map { $0.data }
        tag.writeMultipleBlocks(requestFlags: requestFlags, blockRange: NSMakeRange(blockNumber, numberOfBlocks), dataBlocks: dataBlocks) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func getMultipleBlockSecurityStatus(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! Int
        let numberOfBlocks = arguments["numberOfBlocks"] as! Int
        tag.getMultipleBlockSecurityStatus(requestFlags: requestFlags, blockRange: NSMakeRange(blockNumber, numberOfBlocks)) { status, error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(status)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func writeAfi(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let afi = arguments["afi"] as! UInt8
        tag.writeAFI(requestFlags: requestFlags, afi: afi) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func lockAfi(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        tag.lockAFI(requestFlags: requestFlags) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func writeDsfId(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let dsfId = arguments["dsfId"] as! UInt8
        tag.writeDSFID(requestFlags: requestFlags, dsfid: dsfId) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func lockDsfId(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        tag.lockDFSID(requestFlags: requestFlags) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func resetToReady(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        tag.resetToReady(requestFlags: requestFlags) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func select(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        tag.select(requestFlags: requestFlags) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func stayQuiet(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        tag.stayQuiet { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func extendedReadSingleBlock(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! Int
        tag.extendedReadSingleBlock(requestFlags: requestFlags, blockNumber: blockNumber) { dataBlock, error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(dataBlock)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func extendedWriteSingleBlock(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! Int
        let dataBlock = (arguments["dataBlock"] as! FlutterStandardTypedData).data
        tag.extendedWriteSingleBlock(requestFlags: requestFlags, blockNumber: blockNumber, dataBlock: dataBlock) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func extendedLockBlock(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! Int
        tag.extendedLockBlock(requestFlags: requestFlags, blockNumber: blockNumber) { error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(nil)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func extendedReadMultipleBlocks(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let blockNumber = arguments["blockNumber"] as! Int
        let numberOfBlocks = arguments["numberOfBlocks"] as! Int
        tag.extendedReadMultipleBlocks(requestFlags: requestFlags, blockRange: NSMakeRange(blockNumber, numberOfBlocks)) { dataBlocks, error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(dataBlocks)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func getSystemInfo(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        tag.getSystemInfo(requestFlags: requestFlags) { dataStorageFormatIdentifier, applicationFamilyIdentifier, blockSize, totalBlocks, icReference, error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result([
                "dataStorageFormatIdentifier": dataStorageFormatIdentifier,
                "applicationFamilyIdentifier": applicationFamilyIdentifier,
                "blockSize": blockSize,
                "totalBlocks": totalBlocks,
                "icReference": icReference,
            ])
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func customCommand(_ arguments: [String : Any?], result: @escaping FlutterResult) {
        self.tagManager.tagHandler(NFCISO15693Tag.self, arguments, result) { tag in
        let requestFlags = getRequestFlags(arguments["requestFlags"] as! [String])
        let customCommandCode = arguments["customCommandCode"] as! Int
        let customRequestParameters = (arguments["customRequestParameters"] as! FlutterStandardTypedData).data
        tag.customCommand(requestFlags: requestFlags, customCommandCode: customCommandCode, customRequestParameters: customRequestParameters) { data, error in
            if let error = error {
            result(getFlutterError(error))
            } else {
            result(data)
            }
        }
        }
    }

    @available(iOS 13.0, *)
    private func getRequestFlags(_ flags: [String]) -> RequestFlag {
        var flag = RequestFlag()

        flags.forEach { flg in
            switch flg {
            case "address":
                flag.insert(.address)
            case "dualSubCarriers":
                flag.insert(.dualSubCarriers)
            case "highDataRate":
                flag.insert(.highDataRate)
            case "option":
                flag.insert(.option)
            case "protocolExtension":
                flag.insert(.protocolExtension)
            case "select":
                flag.insert(.select)
            default:
                return
            }
        }

        return flag
    }
}