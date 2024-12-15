import 'dart:convert';
import 'package:slides/services/json_handler.dart';
import 'package:slides/data/about_info.dart';
import 'storage_aboutinfo.dart';

class AssetAboutInfo extends StorageAboutInfo {

  @override
  Future<AboutInfo> getAboutInfo() async {
    String aInfo = '';
    AboutInfo aboutInfo = AboutInfo();
    aInfo = await loadJSONStringFromAsset('assets/about.json');
    if (aInfo.isNotEmpty) {
     aboutInfo.fromJson(jsonDecode(aInfo));
    }
    return aboutInfo;
  }

}
