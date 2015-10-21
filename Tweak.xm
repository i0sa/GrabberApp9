#import <substrate.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <AppList/AppList.h>

%hook SBLockScreenSlideUpToAppController

- (void)setTargetApp:(id)arg1 withAppSuggestion:(id)arg2{ //>>  withLSInfo iOS 8 <<  >> withAppSuggestion iOS 9 <<
NSDictionary* settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.i0sa.grabberapp9prefs.plist"];	

BOOL camEnabled = [settings objectForKey:@"camEnabled"] == nil ? NO : [[settings objectForKey:@"camEnabled"] boolValue];
BOOL secAppEnabled = [settings objectForKey:@"secAppEnabled"] == nil ? NO : [[settings objectForKey:@"secAppEnabled"] boolValue];

if(camEnabled == YES){
   SBApplication *camapp = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:@"com.apple.camera"];
   if(arg1 == camapp){
      NSString *appName = [settings valueForKey:@"camApp"] == nil ? @"com.apple.camera" : [settings valueForKey:@"camApp"];
      SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:appName];
      arg1 = app;
   }
}

if(secAppEnabled == YES){
   if(arg1 == nil){ // need to make it limit, to not to make every nil that app
      SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:[settings valueForKey:@"secApp"]];
      arg1 = app;
   }
}

return %orig(arg1, arg2);
}

%end
