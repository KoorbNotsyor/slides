import 'dart:io';
import 'package:slides/constants.dart';
import 'package:slides/stringx.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/control/app_state.dart';
import 'slide.dart';
import 'slide_data.dart';
import 'package:slides/data/slideshow_info.dart';

class SlideDataFolder implements SlideData {

  late final appState;

  bool _newSlideDataFolder = true;

  Directory? _slidesFolder;
  List<String>? _slideFiles = [];
  int _slideCount = 0;
  int _slideIndex = -1;
  bool _sendSlide = false;
  Slide? _s;
  String _slidePath = '';
  String _slideTitle = '';

  final _reSlash = RegExp('[/\]');

  SlideDataFolder() {
    appState = getIt.get<AppState>();
    _newSlideDataFolder = true;
  }

  String? getSlideSource() {
    return appState.slideShowInfo.folderPath;
  }

  Slide? getNextSlide() {

    if (_newSlideDataFolder) {
      _slidesFolder = new Directory(appState.slideShowInfo.folderPath);
      if (_slidesFolder != null) {
        _slideFiles = _slidesFolder
            ?.listSync()
            ?.map((item) => item.path)
            ?.where((item) => item.hasEnding(Constants.IMAGE_FILE_EXTENSIONS))
            ?.toList(growable: false);
        _newSlideDataFolder = false;
        _slideIndex = -1; // re-set
      }
    }
    _s = null;
    if (_slideFiles != null) {
      _slideCount = _slideFiles?.length ?? 0;
      if (_slideCount > 0) {

        // Got some images... (at least 1)

        _slideIndex += 1;  // set to -1 for a new folder, so counts 0,..,N-1
        _sendSlide = true;
        if (_slideIndex >= _slideCount) {
          // Reached end... do we repeat?
          if (!appState.slideShowInfo.repeat) {
            _sendSlide = false;
          } else {
            _slideIndex = 0;
          }
        }

        if (_sendSlide) {
          _slidePath = _slideFiles?[_slideIndex] ?? '';
          _slideTitle = _slidePath
              .split(_reSlash)
              .last ?? '';
          _s = new Slide(title: _slideTitle, path: _slidePath, index: _slideIndex, total: _slideCount);
        }
      }
    }
    return _s;
  }

}