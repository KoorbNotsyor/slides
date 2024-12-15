import 'package:slides/data/slideshow_info.dart';

abstract class StorageSlideshowInfo {
  // Define the data interface required...
  Future<SlideshowInfo> getSlideshowInfo();
  Future<void> saveSlideshowInfo(SlideshowInfo info);
}