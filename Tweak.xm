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
   SBApplication *camapp = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:@"com.apple.camera"];
   if(arg1 == camapp){
      NSString *appName = [settings valueForKey:@"camApp"] == nil ? @"com.apple.camera" : [settings valueForKey:@"camApp"];
      SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:appName];
      arg1 = app;
   }
}

if(secAppEnabled == YES){
   if(arg1 == nil){ // this stands for the left screen grabber, the method is called to check if left screen icon is there or not, and same for the right, nil usually stands for the left screen and camera for the right.
      if([settings valueForKey:@"secApp"]){
	      SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:[settings valueForKey:@"secApp"]];
	      arg1 = app;
      } else {
		  arg1 = nil;
      }
   }
}

return %orig(arg1, arg2);
}

%end
