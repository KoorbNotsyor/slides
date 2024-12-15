import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:slides/control/app_state.dart';
import 'package:slides/data/store/shared_prefs_slideshowinfo.dart';
import 'package:slides/data/store/storage_slideshowinfo.dart';
import 'package:slides/data/store/asset_aboutinfo.dart';
import 'package:slides/data/store/storage_aboutinfo.dart';


final getIt = GetIt.instance;

void setupLocator() {

  // Logging
  // -------
  // logger.v("Verbose Log");
  // logger.d("Debug Log");
  // logger.i("Info Log");
  // logger.w("Warning Log");
  // logger.e("Error Log");
  // logger.wtf("What a terrible failure log");

  getIt.registerLazySingleton<Logger>(() => Logger(
    printer: PrettyPrinter(
        methodCount: 0,
        lineLength: 120,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true,
        printTime: true,
        noBoxingByDefault: true,
        excludeBox: {
          Level.error: false,
        }
    ),
  ));

  //  ... Shared preferences for slideshow info
  getIt.registerLazySingleton<StorageSlideshowInfo>(() => SharedPrefsSlideshowInfo());

  //  ... Assets file for About info info
  getIt.registerLazySingleton<StorageAboutInfo>(() => AssetAboutInfo());

  // ... Application state
  getIt.registerLazySingleton<AppState>(() => AppState());
}
