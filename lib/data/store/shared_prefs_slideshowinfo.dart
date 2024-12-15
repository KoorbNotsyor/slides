import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slides/data/about_info.dart';
import 'package:slides/data/slideshow_info.dart';
import 'storage_slideshowinfo.dart';

class SharedPrefsSlideshowInfo extends StorageSlideshowInfo {

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  static const slideshowInfo_key = 'slideshow_info';
  static const aboutInfo_key = 'about_info';

  @override
  Future<SlideshowInfo> getSlideshowInfo() async {
    String sInfo = '';
    SlideshowInfo showInfo = SlideshowInfo();
    if (await _prefs.containsKey(slideshowInfo_key)) {
      sInfo = await _prefs.getString(slideshowInfo_key) ?? '';
      if (sInfo.isNotEmpty) {
        showInfo.fromJson(jsonDecode(sInfo));
      }
    }
    return showInfo;
  }

  @override
  Future<void> saveSlideshowInfo(SlideshowInfo info) async {
    await _prefs.setString(slideshowInfo_key,jsonEncode(info));
  }

  @override
  Future<AboutInfo> getAboutInfo() async {
    String aInfo = '';
    AboutInfo aboutInfo = AboutInfo();
    if (await _prefs.containsKey(aboutInfo_key)) {
      aInfo = await _prefs.getString(aboutInfo_key) ?? '';
      if (aInfo.isNotEmpty) {
        aboutInfo.fromJson(jsonDecode(aInfo));
      }
    }
    return aboutInfo;
  }

}
