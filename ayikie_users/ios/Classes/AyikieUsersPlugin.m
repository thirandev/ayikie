#import "AyikieUsersPlugin.h"
#if __has_include(<ayikie_users/ayikie_users-Swift.h>)
#import <ayikie_users/ayikie_users-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ayikie_users-Swift.h"
#endif

@implementation AyikieUsersPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAyikieUsersPlugin registerWithRegistrar:registrar];
}
@end
