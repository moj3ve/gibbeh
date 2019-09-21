ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Gibbeh
Gibbeh_FILES = Tweak.xm
Gibbeh_FRAMEWORKS = UIKit AVFoundation AudioToolbox
Gibbeh_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
