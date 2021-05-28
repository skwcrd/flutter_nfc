import CoreNFC
import Flutter

public class NfcSession: NSObject {
    private let channel: FlutterMethodChannel
    private let tagManager: TagManager

    @available(iOS 13.0, *)
    private lazy var session: NFCTagReaderSession? = nil

    public init(_ channel: FlutterMethodChannel, manager tagManager: TagManager) {
        self.channel = channel
        self.tagManager = tagManager
    }

    @available(iOS 13.0, *)
    public func isAvailable(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        result(NFCTagReaderSession.readingAvailable)
    }

    @available(iOS 13.0, *)
    public func startSession(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        guard NFCTagReaderSession.readingAvailable else {
            result(
                FlutterError(
                    code: "unavailable",
                    message: "NFC tag reader unavailable in your phone.",
                    details: nil))
            return
        }

        self.session = NFCTagReaderSession(
            pollingOption: getPollingOption(
                arguments["pollingOption"] as! [String]),
            delegate: self)

        if let alertMessage = arguments["alertMessage"] as? String {
            self.session?.alertMessage = alertMessage
        }

        self.session?.begin()
        result(nil)
    }

    @available(iOS 13.0, *)
    public func stopSession(_ arguments: [String: Any?], result: @escaping FlutterResult) {
        guard let session = session else {
            result(nil)
            return
        }

        if let errorMessage = arguments["errorMessage"] as? String {
            session.invalidate(
                errorMessage: errorMessage)

            self.session = nil
            result(nil)
            return
        }

        if let alertMessage = arguments["alertMessage"] as? String {
            session.alertMessage = alertMessage
        }

        session.invalidate()
        self.session = nil

        result(nil)
    }

    @available(iOS 13.0, *)
    private func getPollingOption(_ options: [String]) -> NFCTagReaderSession.PollingOption {
        var option = NFCTagReaderSession.PollingOption()

        options.forEach { opt in
            switch opt {
            case "iso14443":
                option.insert(.iso14443)
            case "iso15693":
                option.insert(.iso15693)
            case "iso18092":
                option.insert(.iso18092)
            default:
                return
            }
        }

        return option
    }
}

@available(iOS 13.0, *)
extension NfcSession {
    private func getErrorTypeString(_ code: NFCReaderError.Code) -> String {
        switch code {
        case .readerSessionInvalidationErrorUserCanceled:
            return "userCanceled"
        case .readerSessionInvalidationErrorSessionTimeout:
            return "sessionTimeout"
        case .readerSessionInvalidationErrorSessionTerminatedUnexpectedly:
            return "sessionTerminatedUnexpectedly"
        case .readerSessionInvalidationErrorSystemIsBusy:
            return "systemIsBusy"
        case .readerSessionInvalidationErrorFirstNDEFTagRead:
            return "firstNDEFTagRead"
        default:
            return "unknown"
        }
    }

    private func getErrorMap(_ error: Error) -> [String: Any?] {
        if let err = error as? NFCReaderError {
            return [
                "type": self.getErrorTypeString(err.code),
                "message": err.localizedDescription,
                "details": err.userInfo,
            ]
        }

        let err: NSError = error as NSError

        return [
            "type": "\(err.code)",
            "message": err.localizedDescription,
            "details": err.userInfo,
        ]
    }
}

@available(iOS 13.0, *)
extension NfcSession: NFCTagReaderSessionDelegate {
    public func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {}

    public func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        channel.invokeMethod("onError", arguments: self.getErrorMap(error))
    }

    public func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        let tag = tags.first!

        session.connect(to: tag) { error in
            if let error = error {
                // skip tag detection
                print(error)
                return
            }

            self.tagManager.getNFCTagMap(tag) { tag, data, error in
                if let error = error {
                    // skip tag detection
                    print(error)
                    return
                }

                self.channel.invokeMethod("onDiscovered", arguments: data)
            }
        }
    }
}