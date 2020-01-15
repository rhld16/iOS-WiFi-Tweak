#include "PPPrefsRootListController.h"
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>

#define THEME_COLOR [UIColor colorWithRed:75.0 / 255.0 green:194.0 / 255.0 blue:237.0 / 255.0 alpha:1.0];

@implementation PPPrefsRootListController

- (instancetype)init {
	self = [super init];

	if (self) {

		HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
		appearanceSettings.tintColor = THEME_COLOR;
		self.hb_appearanceSettings = appearanceSettings;
	}

	return self;
}

- (void)loadView {
	[super loadView];
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

+ (NSString *)hb_specifierPlist {
	return @"Root";
}

- (void)respring:(id)sender {
	[HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=Pinky Ponk"]];
}

- (void)resetPrefs:(id)sender {
	HBPreferences *prefs =
		[[HBPreferences alloc] initWithIdentifier:@"com.rhld16.pinkyponk.prefs"];
	[prefs removeAllObjects];

	[self respring:sender];
}

@end
