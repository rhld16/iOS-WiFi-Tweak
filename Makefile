include $(THEOS)/makefiles/common.mk
TARGET = iphone:latest:11.0
ARCHS = arm64 arm64e
GO_EASY_ON_ME=1

PACKAGE_VERSION = 1.0

SUBPROJECTS += Tweak Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
