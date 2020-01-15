#line 1 "Tweak.xm"
#import <Cephei/HBPreferences.h>

@interface CCUILabeledRoundButton
@property (nonatomic, copy, readwrite) NSString *title;
@end

@interface SBWiFiManager
-(id)sharedInstance;
-(void)setWiFiEnabled:(BOOL)enabled;
-(bool)wiFiEnabled;
@end

@interface BluetoothManager
-(id)sharedInstance;
-(void)setEnabled:(BOOL)enabled;
-(bool)enabled;

-(void)setPowered:(BOOL)powered;
-(bool)powered;

@end

static BOOL BTenabbled;



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

@class BluetoothManager; @class CCUILabeledRoundButton; 
static void (*_logos_orig$_ungrouped$CCUILabeledRoundButton$buttonTapped$)(_LOGOS_SELF_TYPE_NORMAL CCUILabeledRoundButton* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$CCUILabeledRoundButton$buttonTapped$(_LOGOS_SELF_TYPE_NORMAL CCUILabeledRoundButton* _LOGOS_SELF_CONST, SEL, id); static BOOL (*_logos_orig$_ungrouped$BluetoothManager$setEnabled$)(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL, BOOL); static BOOL _logos_method$_ungrouped$BluetoothManager$setEnabled$(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL, BOOL); static BOOL (*_logos_orig$_ungrouped$BluetoothManager$setPowered$)(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL, BOOL); static BOOL _logos_method$_ungrouped$BluetoothManager$setPowered$(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL, BOOL); static BOOL (*_logos_orig$_ungrouped$BluetoothManager$enabled)(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$BluetoothManager$enabled(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$BluetoothManager(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("BluetoothManager"); } return _klass; }
#line 26 "Tweak.xm"

static void _logos_method$_ungrouped$CCUILabeledRoundButton$buttonTapped$(_LOGOS_SELF_TYPE_NORMAL CCUILabeledRoundButton* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
_logos_orig$_ungrouped$CCUILabeledRoundButton$buttonTapped$(self, _cmd, arg1);

if ([self.title isEqualToString:[[NSBundle bundleWithPath:@"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey:@"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" value:@"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" table:@"Localizable"]]) {
    BluetoothManager *btoothManager = (BluetoothManager *)[_logos_static_class_lookup$BluetoothManager() sharedInstance];
    BOOL enabled = [btoothManager enabled];

    if(enabled) {
        [btoothManager setEnabled:NO];
        [btoothManager setPowered:NO];

        BTenabbled = !enabled ;
    }

    if(!enabled) BTenabbled = YES;
  }
}





static BOOL _logos_method$_ungrouped$BluetoothManager$setEnabled$(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
   return _logos_orig$_ungrouped$BluetoothManager$setEnabled$(self, _cmd, BTenabbled);
}

static BOOL _logos_method$_ungrouped$BluetoothManager$setPowered$(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1){
    return _logos_orig$_ungrouped$BluetoothManager$setPowered$(self, _cmd, BTenabbled);
}

static BOOL _logos_method$_ungrouped$BluetoothManager$enabled(_LOGOS_SELF_TYPE_NORMAL BluetoothManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    BTenabbled = !_logos_orig$_ungrouped$BluetoothManager$enabled(self, _cmd);
    return _logos_orig$_ungrouped$BluetoothManager$enabled(self, _cmd);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CCUILabeledRoundButton = objc_getClass("CCUILabeledRoundButton"); MSHookMessageEx(_logos_class$_ungrouped$CCUILabeledRoundButton, @selector(buttonTapped:), (IMP)&_logos_method$_ungrouped$CCUILabeledRoundButton$buttonTapped$, (IMP*)&_logos_orig$_ungrouped$CCUILabeledRoundButton$buttonTapped$);Class _logos_class$_ungrouped$BluetoothManager = objc_getClass("BluetoothManager"); MSHookMessageEx(_logos_class$_ungrouped$BluetoothManager, @selector(setEnabled:), (IMP)&_logos_method$_ungrouped$BluetoothManager$setEnabled$, (IMP*)&_logos_orig$_ungrouped$BluetoothManager$setEnabled$);MSHookMessageEx(_logos_class$_ungrouped$BluetoothManager, @selector(setPowered:), (IMP)&_logos_method$_ungrouped$BluetoothManager$setPowered$, (IMP*)&_logos_orig$_ungrouped$BluetoothManager$setPowered$);MSHookMessageEx(_logos_class$_ungrouped$BluetoothManager, @selector(enabled), (IMP)&_logos_method$_ungrouped$BluetoothManager$enabled, (IMP*)&_logos_orig$_ungrouped$BluetoothManager$enabled);} }
#line 62 "Tweak.xm"
