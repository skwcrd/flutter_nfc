import CoreNFC
import Flutter

@available(iOS 13.0, *)
extension NSObject {
    private func getFlutterError(_ arg: Error) -> FlutterError {
        return FlutterError(
            code: "\((arg as NSError).code)",
            message: arg.localizedDescription,
            details: nil)
    }
}