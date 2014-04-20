add-prebuilt-app: $(ZIP_DIR)/system/xbin/busybox
	@echo To add prebuilt apps
	$(hide) cp -f $(SYSOUT_DIR)/xbin/shelld $(ZIP_DIR)/system/xbin/
	$(hide) mkdir -p $(ZIP_DIR)/data/media
	$(hide) cp -rf $(DATAOUT_DIR)/media/preinstall_apps/ $(ZIP_DIR)/data/media/

$(ZIP_DIR)/system/xbin/busybox:
	$(hide) cp -f $(SYSOUT_DIR)/xbin/busybox $(ZIP_DIR)/system/xbin/

add-prebuilt-libraries:
	@echo To add prebuilt libraries
ifeq ($(USE_ANDROID_OUT),true)
	$(hide) for file in `find $(SYSOUT_DIR)/lib -type f`; do \
		file=`echo $$file | sed "s#$(SYSOUT_DIR)\/##g"`; \
		match=`grep $$file $(PORT_ROOT)/build/filelist.txt`; \
		if [ $$? -eq 1 ];then \
			mkdir -p $(ZIP_DIR)/system/`dirname $$file`; \
			cp -f $(SYSOUT_DIR)/$$file $(ZIP_DIR)/system/$$file; \
		fi \
    done
else
	$(hide) cp -rf $(SYSOUT_DIR)/lib $(ZIP_DIR)/system
endif

add-prebuilt-media:
	@echo To add prebuilt media files
	$(hide) cp -rf $(SYSOUT_DIR)/media $(ZIP_DIR)/system

add-prebuilt-fonts:
	$(hide) cp -f $(SYSOUT_DIR)/fonts/TobysHand.ttf $(ZIP_DIR)/system/fonts/
	$(hide) cp -f $(SYSOUT_DIR)/fonts/Miui-Bold.ttf $(ZIP_DIR)/system/fonts/
	$(hide) cp -f $(SYSOUT_DIR)/fonts/Miui-Regular.ttf $(ZIP_DIR)/system/fonts/

add-prebuilt-etc-files:
	@echo To add prebuilt files under etc
ifeq ($(USE_ANDROID_OUT),true)
	$(hide) for file in `find $(SYSOUT_DIR)/etc -type f`; do \
		file=`echo $$file | sed "s#$(SYSOUT_DIR)\/##g"`; \
		match=`grep $$file $(PORT_ROOT)/build/filelist.txt`; \
		if [ $$? -eq 1 ];then \
			mkdir -p $(ZIP_DIR)/system/`dirname $$file`; \
			cp -f $(SYSOUT_DIR)/$$file $(ZIP_DIR)/system/$$file; \
		fi \
	done
else
	$(hide) cp -rf $(SYSOUT_DIR)/etc $(ZIP_DIR)/system
endif

add-lbesec-miui:
	@echo To add LBESEC_MIUI
	$(hide) cp -f $(SYSOUT_DIR)/lib/liblbesec.so $(ZIP_DIR)/system/lib/
	$(hide) cp -f $(SYSOUT_DIR)/bin/installd $(ZIP_DIR)/system/bin
	$(hide) cp -f $(SYSOUT_DIR)/app/LBESEC_MIUI.apk $(ZIP_DIR)/system/app
	$(hide) cp -f $(SYSOUT_DIR)/xbin/su $(ZIP_DIR)/system/xbin/

add-skia-emoji:
	@echo To add Skia Emoji support
	$(hide) cp -f $(SYSOUT_DIR)/lib/libskia.so $(ZIP_DIR)/sysem/lib
	$(hide) cp -f $(SYSOUT_DIR)/lib/libhwui.so $(ZIP_DIR)/system/lib

release-prebuilt-app:
	@echo Release prebuilt apps
	$(hide) mkdir -p $(RELEASE_PATH)/$(DENSITY)/system/xbin
	$(hide) cp $(SYSOUT_DIR)/xbin/shelld $(RELEASE_PATH)/$(DENSITY)/system/xbin/
	$(hide) cp $(SYSOUT_DIR)/xbin/busybox $(RELEASE_PATH)/$(DENSITY)/system/xbin/
	$(hide) mkdir -p $(RELEASE_PATH)/$(DENSITY)/system/bin
	$(hide) cp $(SYSOUT_DIR)/bin/installd $(RELEASE_PATH)/$(DENSITY)/system/bin/
	$(hide) cp -f $(SYSOUT_DIR)/app/LBESEC_MIUI.apk $(RELEASE_PATH)/$(DENSITY)/system/app
	$(hide) cp -f $(SYSOUT_DIR)/xbin/su $(RELEASE_PATH)/$(DENSITY)/system/xbin/
	$(hide) mkdir -p $(RELEASE_PATH)/data/media
	$(hide) cp -rf $(DATAOUT_DIR)/media/preinstall_apps/ $(RELEASE_PATH)/data/media/


release-prebuilt-libraries:
	@echo Release prebuilt libraries
	$(hide) for dir in `find $(SYSOUT_DIR)/lib -type d`; do \
		path=`echo $$dir | sed "s#$(SYSOUT_DIR)\/##g"`; \
		mkdir -p $(RELEASE_PATH)/$(DENSITY)/system/$$path; \
	done
	$(hide) for file in `find $(SYSOUT_DIR)/lib -type f`; do \
		file=`echo $$file | sed "s#$(SYSOUT_DIR)\/##g"`; \
		match=`grep $$file $(PORT_ROOT)/build/filelist.txt`; \
		if [ $$? -eq 1 ];then \
			cp -f $(SYSOUT_DIR)/$$file $(RELEASE_PATH)/$(DENSITY)/system/$$file; \
		fi \
	done

release-prebuilt-media:
	@echo Release prebuilt media files
	$(hide) mkdir -p $(RELEASE_PATH)/$(DENSITY)/system/media
	$(hide) cp -rf $(SYSOUT_DIR)/media $(RELEASE_PATH)/$(DENSITY)/system

release-prebuilt-fonts:
	$(hide) mkdir -p $(RELEASE_PATH)/$(DENSITY)/system/fonts/
	$(hide) cp -f $(SYSOUT_DIR)/fonts/TobysHand.ttf $(RELEASE_PATH)/$(DENSITY)/system/fonts/
	$(hide) cp -f $(SYSOUT_DIR)/fonts/Miui-Bold.ttf $(RELEASE_PATH)/$(DENSITY)/system/fonts/
	$(hide) cp -f $(SYSOUT_DIR)/fonts/Miui-Regular.ttf $(RELEASE_PATH)/$(DENSITY)/system/fonts/

release-prebuilt-etc-files:
	@echo Release prebuilt etc-files
	$(hide) for dir in `find $(SYSOUT_DIR)/etc -type d`; do \
		path=`echo $$dir | sed "s#$(SYSOUT_DIR)\/##g"`; \
		mkdir -p $(RELEASE_PATH)/$(DENSITY)/system/$$path; \
	done
	$(hide) for file in `find $(SYSOUT_DIR)/etc -type f`; do \
		file=`echo $$file | sed "s#$(SYSOUT_DIR)\/##g"`; \
		match=`grep $$file $(PORT_ROOT)/build/filelist.txt`; \
		if [ $$? -eq 1 ];then \
			cp -f $(SYSOUT_DIR)/$$file $(RELEASE_PATH)/$(DENSITY)/system/$$file; \
		fi \
	done

release-miui-resources:
	@echo release miui resources
	$(hide) mkdir -p $(RELEASE_PATH)/src/frameworks/miui
	$(hide) cp -r $(ANDROID_TOP)/frameworks/miui/overlay $(RELEASE_PATH)/src/frameworks/miui
	$(hide) mkdir -p $(RELEASE_PATH)/src/frameworks/miui/$(ANDROID_PLATFORM)/overlay/frameworks/base/core/res
	$(hide) cp -r $(ANDROID_TOP)/frameworks/miui/$(ANDROID_PLATFORM)/overlay/frameworks/base/core/res/res $(RELEASE_PATH)/src/frameworks/miui/$(ANDROID_PLATFORM)/overlay/frameworks/base/core/res &
	$(hide) mkdir -p $(RELEASE_PATH)/src/frameworks/miui/core/res
	$(hide) cp -r $(ANDROID_TOP)/frameworks/miui/core/res/res $(RELEASE_PATH)/src/frameworks/miui/core/res
	$(hide) mkdir -p $(RELEASE_PATH)/src/frameworks/miui/$(ANDROID_PLATFORM)/overlay/frameworks/miui/core/res
	$(hide) cp -r $(ANDROID_TOP)/frameworks/miui/$(ANDROID_PLATFORM)/overlay/frameworks/miui/core/res/res $(RELEASE_PATH)/src/frameworks/miui/$(ANDROID_PLATFORM)/overlay/frameworks/miui/core/res &
	$(hide) mkdir -p $(RELEASE_PATH)/src/frameworks/miui-opt/keyguard
	$(hide) cp -r $(ANDROID_TOP)/frameworks/miui-opt/keyguard/res $(RELEASE_PATH)/src/frameworks/miui-opt/keyguard
	$(hide) cd $(ANDROID_TOP); tar -cf $(RELEASE_PATH)/src/res.tar packages/apps/*/res
	$(hide) cd $(RELEASE_PATH)/src;tar -xf res.tar;rm res.tar

add-miui-prebuilt: add-prebuilt-app add-prebuilt-libraries add-prebuilt-media add-prebuilt-fonts add-prebuilt-etc-files add-lbesec-miui
	@echo Add miui prebuilt completed!

release-miui-prebuilt: release-prebuilt-app release-prebuilt-libraries release-prebuilt-media release-prebuilt-fonts release-prebuilt-etc-files release-miui-resources
	@echo Release MIUI prebuilt completed!
