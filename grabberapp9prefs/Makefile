TARGET := iphone:clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = grabberapp9prefs
grabberapp9prefs_FILES = grabberapp9prefs.mm
grabberapp9prefs_INSTALL_PATH = /Library/PreferenceBundles
grabberapp9prefs_FRAMEWORKS = UIKit CoreGraphics
grabberapp9prefs_LIBRARIES = applist
grabberapp9prefs_LDFLAGS = -L$(FW_OBJ_DIR)

grabberapp9prefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/grabberapp9prefs.plist$(ECHO_END)
