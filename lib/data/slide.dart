import 'package:flutter/services.dart';
import 'dart:typed_data';

class Slide {

  late String _title;
  late String _path;
  late int _index;
  late int _total;

//  Uint8List? _bytes = null;
//  bool _gettingImage = false;

  Slide({required String title, required String path, int index=0, int total=0}){
    _title = title;
    _path = path;
    _index = index;
    _total = total;
  }

  void set setTitle(String title) {
    _title = title;
  }

  String get getTitle {
    return _title;
  }

  void set setPath(String path) {
    _path = path;
  }

  String get getPath {
    return _path;
  }

  int get index => _index;
  set index(n) => _index = n;

  int get total => _total;
  set total(n) => _total = n;

//  Uint8List? get data {
//    return _bytes;
//  }

// bool get hasData {
//    if (_bytes ==  null) {
//      return false;
//    }
//    return true;
//  }

//  bool get loading {
//    return _gettingImage;
//  }

//  void getImage() async {
//    _gettingImage = true;
//    ByteData data = await NetworkAssetBundle(Uri.parse(_url)).load(_url);
//    _bytes = data.buffer.asUint8List();
//    //print(_bytes);
//  }

  //JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = getTitle;
    data['path'] = getPath;
    return data;
  }

  Slide.fromJson(Map<String, dynamic>json) {
   _title = json['title'];
   _path = json['path'];
  }

}