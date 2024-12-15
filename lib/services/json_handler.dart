import 'dart:convert';
import 'package:flutter/services.dart';

Future<String> loadJSONStringFromAsset(String filePath) async {
  String sJSON;
  try {
    sJSON = await rootBundle.loadString(filePath);
  } catch (e) {
    // Problem... return empty string
    print(e);
    sJSON = '';
  }
  return sJSON;
}

Future<Map<String, dynamic>> loadJSONMapFromAsset(String filePath) async {
  String sJSON = await loadJSONStringFromAsset(filePath);
  return jsonDecode(sJSON);
}
