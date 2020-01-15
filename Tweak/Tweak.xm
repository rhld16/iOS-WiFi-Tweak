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

bool pEnabled = YES;
bool pBluetoothEnabled = YES;
bool pWifiEnabled = YES;

HBPreferences *preferences;
NSMutableArray *widgetsArray;
NotificationController *notificationController;


%hook CCUILabeledRoundButton
-(void)buttonTapped:(id)arg1{
%orig;

if ([self.title isEqualToString:[[NSBundle bundleWithPath:@"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey:@"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" value:@"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" table:@"Localizable"]]) {
    BluetoothManager *btoothManager = (BluetoothManager *)[%c(BluetoothManager) sharedInstance];
    BOOL enabled = [btoothManager enabled];

    if(enabled && pBluetoothEnabled && pEnabled) {
        [btoothManager setEnabled:NO];
        [btoothManager setPowered:NO];

        BTenabbled = !enabled ;
    }

    if(!enabled) BTenabbled = YES;
  }
}
%end

%hook BluetoothManager


- (BOOL)setEnabled:(BOOL)arg1 {
   return %orig(BTenabbled);
}

- (BOOL)setPowered:(BOOL)arg1{
    return %orig(BTenabbled);
}

-(BOOL)enabled {
    BTenabbled = !%orig;
    return %orig;
}
%end

%ctor {
	reloadPrefs();

	NSString *notificationControllerClass = @"SBDashBoardNotificationAdjunctListViewController";

	if(@available(iOS 13.0, *)) {
		notificationControllerClass = @"CSNotificationAdjunctListViewController";
	}

	%init(group, NotificationController = NSClassFromString(notificationControllerClass));

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, CFSTR("me.rhld16.pinkyponk.prefs/ReloadPrefs"), NULL, kNilOptions);
}