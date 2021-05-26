import Flutter
import CoreNFC

public class SwiftFlutterNfcPlugin: NSObject, FlutterPlugin {
    private let session: NfcSession
    private let tagManager: TagManager

    private let ndef: Ndef
    private let mifare: Mifare
    private let felica: Felica
    private let iso7816: Iso7816
    private let iso15693: Iso15693

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "plugin.skwcrd.com/flutter_nfc",
            binaryMessenger: registrar.messenger())

        let instance = SwiftFlutterNfcPlugin(channel)

        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private init(_ channel: FlutterMethodChannel) {
        self.tagManager = TagManager()

        self.session = NfcSession(channel, manager: tagManager)

        self.ndef = Ndef(tagManager)
        self.mifare = Mifare(tagManager)
        self.felica = Felica(tagManager)
        self.iso7816 = Iso7816(tagManager)
        self.iso15693 = Iso15693(tagManager)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard #available(iOS 13.0, *) else {
            result(
                FlutterError(
                    code: "unavailable",
                    message: "Only available in iOS 13.0 or newer",
                    details: nil))
            return
        }

        switch call.method {
        case "isAvailable":
            self.session.isAvailable(call.arguments as! [String: Any?], result: result)
        case "startSession":
            self.session.startSession(call.arguments as! [String: Any?], result: result)
        case "stopSession":
            self.session.stopSession(call.arguments as! [String: Any?], result: result)
        case "disposeTag":
            self.tagManager.disposeTag(call.arguments as! [String : Any?], result: result)
        case "Ndef":
            self.ndef.handle(call.arguments as! [String : Any?], result: result)
        case "Mifare":
            self.mifare.handle(call.arguments as! [String : Any?], result: result)
        case "Felica":
            self.felica.handle(call.arguments as! [String : Any?], result: result)
        case "Iso7816":
            self.iso7816.handle(call.arguments as! [String : Any?], result: result)
        case "Iso15693":
            self.iso15693.handle(call.arguments as! [String : Any?], result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}