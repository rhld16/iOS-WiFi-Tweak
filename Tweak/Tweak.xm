#import <Cephei/HBPreferences.h>
#include <dlfcn.h>

BOOL pEnabled;
BOOL pWifiTap;
BOOL pBlueTap;

HBPreferences *preferences;
NSMutableDictionary *iconDictionary = [[NSMutableDictionary alloc] init];

@interface BluetoothManager : NSObject
@end

@interface BluetoothManager (Addition)
@property(assign) BOOL ignoreAirplaneModeCheck;
@end
%group BlueTap
%hook BluetoothManager

%property(assign) BOOL ignoreAirplaneModeCheck;

- (void)_updateAirplaneModeStatus {
    if (self.ignoreAirplaneModeCheck)
        return;
    %orig;
}

- (void)bluetoothStateActionWithCompletion:(void *)completion {
    bool airplaneMode = MSHookIvar<bool>(self, "_airplaneMode");
    MSHookIvar<bool>(self, "_airplaneMode") = YES;
    self.ignoreAirplaneModeCheck = YES;
    %orig;
    MSHookIvar<bool>(self, "_airplaneMode") = airplaneMode;
    self.ignoreAirplaneModeCheck = NO;
}

%end
%end
%group WifiTap
@interface WFWiFiStateMonitor : NSObject
@end

@interface WFControlCenterStateMonitor : WFWiFiStateMonitor
@end

@interface WFControlCenterStateMonitor (Addition)
@property(assign) BOOL forceAirplaneMode;
@end

// For Wi-Fi though, WiFiKit.framework isn't available in x86_64 so it's a bit difficult to know what's going on as we toggle it.
// However, using the same trick as we did for bluetooth seems to also work here.

%hook WFControlCenterStateMonitor

%property(assign) BOOL forceAirplaneMode;

- (BOOL)_airplaneModeEnabled {
    return self.forceAirplaneMode ? YES : %orig;
}

- (void)performAction:(void *)completion {
    self.forceAirplaneMode = YES; // Do we always force airplane mode?
    %orig;
    self.forceAirplaneMode = NO;
}

%end
%end
void reloadPrefs() {
	NSLog(@"[PinkyPonk] (reloadPrefs) (DEBUG) Reloading Preferences...");

	preferences = [[HBPreferences alloc] initWithIdentifier:@"me.rhld16.pinkyponk.prefs"];

  [preferences registerDefaults:@{
        @"pEnabled": @YES,
        @"pBlueTap": @YES,
        @"pWifiTap": @YES
  }];

	[preferences registerBool:&pEnabled default:YES forKey:@"pEnabled"];
	[preferences registerBool:&pBlueTap default:YES forKey:@"pBlueTap"];
	[preferences registerBool:&pWifiTap default:YES forKey:@"pWifiTap"];

	NSLog(@"[PinkyPonk] (reloadPrefs) (DEBUG) Current Enabled State: %i", pEnabled);
	NSLog(@"[PinkyPonk] (reloadPrefs) (DEBUG) Bluetooth: %i", pBlueTap);
  NSLog(@"[PinkyPonk] (reloadPrefs) (DEBUG) Wifi: %i", pWifiTap);
}

%ctor {
	reloadPrefs();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("me.rhld16.pinkyponk.prefs/ReloadPrefs"), NULL, kNilOptions);
    dlopen("/System/Library/PrivateFrameworks/BluetoothManager.framework/BluetoothManager", RTLD_LAZY);
    dlopen("/System/Library/PrivateFrameworks/WiFiKit.framework/WiFiKit", RTLD_LAZY);
    if (pEnabled && pBlueTap == YES) {
		%init(BlueTap);
	} else  {
	}
    if (pEnabled && pWifiTap == YES) {
		%init(WifiTap);
	} else  {
	}
}