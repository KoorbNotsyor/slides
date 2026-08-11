import 'dart:math';

import 'package:flutter/services.dart';
import 'dart:typed_data';

class Slide {

  late String _title;
  late String _path;
  late String _mimeType;
  late String _extension;
  late bool _isVideo;
  late int _index;
  late int _total;

//  Uint8List? _bytes = null;
//  bool _gettingImage = false;

  Slide({ required String title,
          required String path,
          required String mimeType,
          required String extension,
          bool isVideo = false,
          int index=0,
          int total=0}
          ){
    _title = title;
    _path = path;
    _mimeType = mimeType;
    _extension = extension;
    _isVideo = isVideo;
    _index = index;
    _total = total;
  }

  set title(String title) {_title = title;}
  String get title {return _title;}

  set path(String path) {_path = path;}
  String get path {return _path;}

  set mimeType(String mimeType) { _mimeType = mimeType;}
  String get mimeType {return _mimeType;}

  set extension(String extension) {_extension = extension;}
  String get extension {return _extension;}

  bool get isVideo => _isVideo;
  set isVideo(b) => _isVideo = b;

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
    data['title'] = title;
    data['path'] = path;
    data['mimeType'] = mimeType;
    data['extension'] = extension;
    data['isVideo'] = isVideo;
    return data;
  }

  Slide.fromJson(Map<String, dynamic>json) {
   _title = json['title'];
   _path = json['path'];
   _mimeType = json['mimeType'];
   _extension = json['extension'];
   _isVideo = json['isVideo'];
  }

}