#import <Preferences/Preferences.h>
#define grabberPreferencePath @"/var/mobile/Library/Preferences/com.i0sa.grabberapp9prefs.plist"

@interface grabberapp9prefsListController: PSListController {
}
@end

@implementation grabberapp9prefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"grabberapp9prefs" target:self] retain];
	}
	return _specifiers;
}
-(void)respring {
   system("killall -9 SpringBoard");
}
-(id) readPreferenceValue:(PSSpecifier*)specifier {
	NSDictionary *grabberSettings = [NSDictionary dictionaryWithContentsOfFile:grabberPreferencePath];
	if (!grabberSettings[specifier.properties[@"key"]]) {
		return specifier.properties[@"default"];
	}
	return grabberSettings[specifier.properties[@"key"]];
}
 
-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
	[defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:grabberPreferencePath]];
	[defaults setObject:value forKey:specifier.properties[@"key"]];
	[defaults writeToFile:grabberPreferencePath atomically:YES];
	NSDictionary *grabberSettings = [NSDictionary dictionaryWithContentsOfFile:grabberPreferencePath];
		NSLog(@"PreferenceOrganizer2: [DEBUG] POSettings %@",grabberSettings);
	CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
	if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}
@end

// vim:ft=objc
