include $(THEOS)/makefiles/common.mk

GO_EASY_ON_ME=1

PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

SUBPROJECTS += Tweak Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
