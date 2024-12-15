import 'package:slides/data/about_info.dart';

abstract class StorageAboutInfo {
  // Define the data interface required...
  Future<AboutInfo> getAboutInfo();
  // NOT IMPLEMENTED - READ ONLY? Future<void> saveAboutInfo(AboutInfo info);
}