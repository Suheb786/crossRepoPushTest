#import "InfobipPlugin.h"
#if __has_include(<infobip_plugin/infobip_plugin-Swift.h>)
#import <infobip_plugin/infobip_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "infobip_plugin-Swift.h"
#endif

@implementation InfobipPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInfobipPlugin registerWithRegistrar:registrar];
}
@end
