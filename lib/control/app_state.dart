import 'package:flutter/material.dart';
import 'package:slides/data/slideshow_info.dart';
import 'package:slides/data/about_info.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/data/store/storage_slideshowinfo.dart';
import 'package:slides/data/store/storage_aboutinfo.dart';
import 'package:package_info_plus/package_info_plus.dart';

/*
      This is the application state.
 */

enum AppStatus {
  uninitialised,        // Application launched... not yet fully initialised
  initialised,          // Application initialised, ready to go...
}

class AppState {

  // Notifiers...
  final ValueNotifier<SlideshowInfo> showInfo = ValueNotifier<SlideshowInfo>(SlideshowInfo());

  // About screen info
  late AboutInfo aboutInfo;

  // App information
  late PackageInfo _packageInfo;
  String _appName = '';
  String _packageName = '';
  String _version = '';
  String _buildNumber = '';

  AppStatus appStatus = AppStatus.uninitialised;

  AppState() {}

  String get appName => _appName;
  String get version => _version;
  String get buildNumber => _buildNumber;

  void setAppState(AppStatus newAppState) {
    appStatus = newAppState;
  }

  Future<bool> setup( ) async {
    String? emessage = null;
    bool setupOK = false;
    try {

      // Testing ... delay
      //await Future.delayed(const Duration(milliseconds: 1000));

      final prefsInfoStore = getIt.get<StorageSlideshowInfo>();
      showInfo.value = await prefsInfoStore.getSlideshowInfo();

      final aboutInfoStore = getIt.get<StorageAboutInfo>();
      aboutInfo = await aboutInfoStore.getAboutInfo(); // Could be in About screen ???

      // App information...
      _packageInfo = await PackageInfo.fromPlatform();
      _appName = _packageInfo.appName;
      _packageName = _packageInfo.packageName;
      _version = _packageInfo.version;
      _buildNumber = _packageInfo.buildNumber;

      //print('App [$_appName] Package [$_packageName] Version [$_version] Build [$_buildNumber]');

      setupOK = true;
    } catch (e) {
      emessage = 'SETUP: Unspecified exception [$e]';
     } finally {

    }
    return setupOK;
  }

  Future<void> saveSlideShowDetails() async {
    final prefsInfoStore = getIt.get<StorageSlideshowInfo>();
    await prefsInfoStore.saveSlideshowInfo(showInfo.value);
  }

  SlideshowInfo get slideShowInfo => showInfo.value;
  set slideShowInfo(SlideshowInfo ssi) {
    showInfo.value = ssi;
  }

}


