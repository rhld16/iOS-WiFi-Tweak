include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PPPrefs

PPPrefs_FILES = PPPrefsRootListController.m
PPPrefs_INSTALL_PATH = /Library/PreferenceBundles
PPPrefs_PRIVATE_FRAMEWORKS = Preferences
PPPrefs_CFLAGS = -fobjc-arc
PPPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/PPPrefs.plist$(ECHO_END)