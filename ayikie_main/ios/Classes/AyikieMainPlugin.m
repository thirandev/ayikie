#import "AyikieMainPlugin.h"
#if __has_include(<ayikie_main/ayikie_main-Swift.h>)
#import <ayikie_main/ayikie_main-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ayikie_main-Swift.h"
#endif

@implementation AyikieMainPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAyikieMainPlugin registerWithRegistrar:registrar];
}
@end
