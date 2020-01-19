#line 1 "Tweak.xm"
#import <Cephei/HBPreferences.h>
#include <dlfcn.h>

BOOL pEnabled;
BOOL pWifiTap;
BOOL pBlueTap;

HBPreferences *preferences;
NSMutableDictionary *iconDictionary = [[NSMutableDictionary alloc] init];

@interface BluetoothManager : NSObject
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class BluetoothManager; @class WFControlCenterStateMonitor; 


#line 14 "Tweak.xm"
@interface BluetoothManager (Addition)
@property(assign) BOOL ignoreAirplaneModeCheck;
@end
static void (*_logos_orig$BlueTap$BluetoothManager$_updateAirplaneModeStatus)(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL); static void _logos_method$BlueTap$BluetoothManager$_updateAirplaneModeStatus(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$BlueTap$BluetoothManager$bluetoothStateActionWithCompletion$)(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL, void *); static void _logos_method$BlueTap$BluetoothManager$bluetoothStateActionWithCompletion$(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL, void *); 


__attribute__((used)) static BOOL _logos_method$BlueTap$BluetoothManager$ignoreAirplaneModeCheck(BluetoothManager * __unused self, SEL __unused _cmd) { NSValue * value = objc_getAssociatedObject(self, (void *)_logos_method$BlueTap$BluetoothManager$ignoreAirplaneModeCheck); BOOL rawValue; [value getValue:&rawValue]; return rawValue; }; __attribute__((used)) static void _logos_method$BlueTap$BluetoothManager$setIgnoreAirplaneModeCheck(BluetoothManager * __unused self, SEL __unused _cmd, BOOL rawValue) { NSValue * value = [NSValue valueWithBytes:&rawValue objCType:@encode(BOOL)]; objc_setAssociatedObject(self, (void *)_logos_method$BlueTap$BluetoothManager$ignoreAirplaneModeCheck, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static void _logos_method$BlueTap$BluetoothManager$_updateAirplaneModeStatus(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (self.ignoreAirplaneModeCheck)
        return;
    _logos_orig$BlueTap$BluetoothManager$_updateAirplaneModeStatus(self, _cmd);
}

static void _logos_method$BlueTap$BluetoothManager$bluetoothStateActionWithCompletion$(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, void * completion) {
    bool airplaneMode = MSHookIvar<bool>(self, "_airplaneMode");
    MSHookIvar<bool>(self, "_airplaneMode") = YES;
    self.ignoreAirplaneModeCheck = YES;
    _logos_orig$BlueTap$BluetoothManager$bluetoothStateActionWithCompletion$(self, _cmd, completion);
    MSHookIvar<bool>(self, "_airplaneMode") = airplaneMode;
    self.ignoreAirplaneModeCheck = NO;
}



static BOOL (*_logos_orig$WifiTap$WFControlCenterStateMonitor$_airplaneModeEnabled)(_LOGOS_SELF_TYPE_NORMAL WFControlCenterStateMonitor* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$WifiTap$WFControlCenterStateMonitor$_airplaneModeEnabled(_LOGOS_SELF_TYPE_NORMAL WFControlCenterStateMonitor* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$WifiTap$WFControlCenterStateMonitor$performAction$)(_LOGOS_SELF_TYPE_NORMAL WFControlCenterStateMonitor* _LOGOS_SELF_CONST, SEL, void *); static void _logos_method$WifiTap$WFControlCenterStateMonitor$performAction$(_LOGOS_SELF_TYPE_NORMAL WFControlCenterStateMonitor* _LOGOS_SELF_CONST, SEL, void *); 
@interface WFWiFiStateMonitor : NSObject
@end

@interface WFControlCenterStateMonitor : WFWiFiStateMonitor
@end

@interface WFControlCenterStateMonitor (Addition)
@property(assign) BOOL forceAirplaneMode;
@end






__attribute__((used)) static BOOL _logos_method$WifiTap$WFControlCenterStateMonitor$forceAirplaneMode(WFControlCenterStateMonitor * __unused self, SEL __unused _cmd) { NSValue * value = objc_getAssociatedObject(self, (void *)_logos_method$WifiTap$WFControlCenterStateMonitor$forceAirplaneMode); BOOL rawValue; [value getValue:&rawValue]; return rawValue; }; __attribute__((used)) static void _logos_method$WifiTap$WFControlCenterStateMonitor$setForceAirplaneMode(WFControlCenterStateMonitor * __unused self, SEL __unused _cmd, BOOL rawValue) { NSValue * value = [NSValue valueWithBytes:&rawValue objCType:@encode(BOOL)]; objc_setAssociatedObject(self, (void *)_logos_method$WifiTap$WFControlCenterStateMonitor$forceAirplaneMode, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

static BOOL _logos_method$WifiTap$WFControlCenterStateMonitor$_airplaneModeEnabled(_LOGOS_SELF_TYPE_NORMAL WFControlCenterStateMonitor* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return self.forceAirplaneMode ? YES : _logos_orig$WifiTap$WFControlCenterStateMonitor$_airplaneModeEnabled(self, _cmd);
}

static void _logos_method$WifiTap$WFControlCenterStateMonitor$performAction$(_LOGOS_SELF_TYPE_NORMAL WFControlCenterStateMonitor* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, void * completion) {
    self.forceAirplaneMode = YES; 
    _logos_orig$WifiTap$WFControlCenterStateMonitor$performAction$(self, _cmd, completion);
    self.forceAirplaneMode = NO;
}



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

static __attribute__((constructor)) void _logosLocalCtor_14742edd(int __unused argc, char __unused **argv, char __unused **envp) {
	reloadPrefs();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("me.rhld16.pinkyponk.prefs/ReloadPrefs"), NULL, kNilOptions);
    dlopen("/System/Library/PrivateFrameworks/BluetoothManager.framework/BluetoothManager", RTLD_LAZY);
    dlopen("/System/Library/PrivateFrameworks/WiFiKit.framework/WiFiKit", RTLD_LAZY);
    if (pEnabled && pBlueTap == YES) {
		{Class _logos_class$BlueTap$BluetoothManager = objc_getClass("BluetoothManager"); MSHookMessageEx(_logos_class$BlueTap$BluetoothManager, @selector(_updateAirplaneModeStatus), (IMP)&_logos_method$BlueTap$BluetoothManager$_updateAirplaneModeStatus, (IMP*)&_logos_orig$BlueTap$BluetoothManager$_updateAirplaneModeStatus);MSHookMessageEx(_logos_class$BlueTap$BluetoothManager, @selector(bluetoothStateActionWithCompletion:), (IMP)&_logos_method$BlueTap$BluetoothManager$bluetoothStateActionWithCompletion$, (IMP*)&_logos_orig$BlueTap$BluetoothManager$bluetoothStateActionWithCompletion$);{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(BOOL)); class_addMethod(_logos_class$BlueTap$BluetoothManager, @selector(ignoreAirplaneModeCheck), (IMP)&_logos_method$BlueTap$BluetoothManager$ignoreAirplaneModeCheck, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(BOOL)); class_addMethod(_logos_class$BlueTap$BluetoothManager, @selector(setIgnoreAirplaneModeCheck:), (IMP)&_logos_method$BlueTap$BluetoothManager$setIgnoreAirplaneModeCheck, _typeEncoding); } }
	} else  {
	}
    if (pEnabled && pWifiTap == YES) {
		{Class _logos_class$WifiTap$WFControlCenterStateMonitor = objc_getClass("WFControlCenterStateMonitor"); MSHookMessageEx(_logos_class$WifiTap$WFControlCenterStateMonitor, @selector(_airplaneModeEnabled), (IMP)&_logos_method$WifiTap$WFControlCenterStateMonitor$_airplaneModeEnabled, (IMP*)&_logos_orig$WifiTap$WFControlCenterStateMonitor$_airplaneModeEnabled);MSHookMessageEx(_logos_class$WifiTap$WFControlCenterStateMonitor, @selector(performAction:), (IMP)&_logos_method$WifiTap$WFControlCenterStateMonitor$performAction$, (IMP*)&_logos_orig$WifiTap$WFControlCenterStateMonitor$performAction$);{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(BOOL)); class_addMethod(_logos_class$WifiTap$WFControlCenterStateMonitor, @selector(forceAirplaneMode), (IMP)&_logos_method$WifiTap$WFControlCenterStateMonitor$forceAirplaneMode, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(BOOL)); class_addMethod(_logos_class$WifiTap$WFControlCenterStateMonitor, @selector(setForceAirplaneMode:), (IMP)&_logos_method$WifiTap$WFControlCenterStateMonitor$setForceAirplaneMode, _typeEncoding); } }
	} else  {
	}
}
