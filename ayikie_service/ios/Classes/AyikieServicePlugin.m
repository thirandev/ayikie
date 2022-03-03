#import "AyikieServicePlugin.h"
#if __has_include(<ayikie_service/ayikie_service-Swift.h>)
#import <ayikie_service/ayikie_service-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ayikie_service-Swift.h"
#endif

@implementation AyikieServicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAyikieServicePlugin registerWithRegistrar:registrar];
}
@end
