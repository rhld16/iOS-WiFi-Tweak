#include "PPPrefsRootListController.h"
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>

#define THEME_COLOR [UIColor colorWithRed:91.0 / 255.0 green:116.0 / 255.0 blue:55.0 / 255.0 alpha:1.0];

@implementation PPPrefsRootListController

- (instancetype)init {
	self = [super init];

	if (self) {

		HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
		appearanceSettings.tintColor = THEME_COLOR;
		self.hb_appearanceSettings = appearanceSettings;
		self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring" 
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(respring)];
        self.respringButton.tintColor = THEME_COLOR;
        self.navigationItem.rightBarButtonItem = self.respringButton;
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
