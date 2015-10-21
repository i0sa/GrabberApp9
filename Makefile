TARGET := iphone:clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = GrabberApp9
GrabberApp9_FILES = Tweak.xm
GrabberApp9_FRAMEWORKS = UIKit
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += grabberapp9prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
