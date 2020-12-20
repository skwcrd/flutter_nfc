#import "FlutterNfcPlugin.h"
#if __has_include(<flutter_nfc/flutter_nfc-Swift.h>)
#import <flutter_nfc/flutter_nfc-Swift.h>
#else
#import "flutter_nfc-Swift.h"
#endif

@implementation FlutterNfcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNfcPlugin registerWithRegistrar:registrar];
}
@end