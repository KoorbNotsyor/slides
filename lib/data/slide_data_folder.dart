import 'dart:io';
import 'package:slides/constants.dart';
import 'package:slides/stringx.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/control/app_state.dart';
import 'slide.dart';
import 'slide_data.dart';
import 'package:mime/mime.dart';

class SlideDataFolder implements SlideData {

  late final appState;

  bool _newSlideDataFolder = true;

//  Directory? _slidesFolder;
  Directory _slidesFolder = Directory('');
  List<String>? _slideFiles = [];
  int _slideCount = 0;
  int _slideIndex = -1;
  bool _sendSlide = false;
  Slide? _s;
  String _slidePath = '';
  String _slideTitle = '';
  bool _shuffle = false;

  final _reSlash = RegExp('[/\]');

  SlideDataFolder() {
    appState = getIt.get<AppState>();
    _newSlideDataFolder = true;
  }

  String? getSlideSource() {
    return appState.slideShowInfo.folderPath;
  }

  Slide? getNextSlide() {

    /*
     * ? Possibly, instead of file extensions, use:

      import 'package:mime/mime.dart';

      bool isImage(String path) {
        final mimeType = lookupMimeType(path);

        return mimeType.startsWith('image/');
      }

     *
     */

    if (_newSlideDataFolder) {
      _slideFiles = [];
      _slidesFolder = new Directory(appState.slideShowInfo.folderPath);
      List<FileSystemEntity> fse = _slidesFolder.listSync();
      if(fse.isNotEmpty) {
        final String extensions = appState.slideShowInfo.mediaTypeExtensions;
        List<String> extensionsList = extensions.toLowerCase().decompose();
        //print('Extensions: [$extensions]');
        //print('Extensions list: $extensionsList');
        _slideFiles = fse.map((item) => item.path)
                        .where((item) => item.toLowerCase().hasEnding(extensionsList))
                        .toList(growable:false);
      } else {
      //print('FSE[] is empty...');
      }
      _newSlideDataFolder = false;
      _slideIndex = -1; // re-set
      _shuffle = appState.slideShowInfo.shuffle;
    }

    _s = null;
    if (_slideFiles != null) {
      _slideCount = _slideFiles?.length ?? 0;
      if (_slideCount > 0) {

        // Got some images... (at least 1)
        _slideIndex += 1;  // set to -1 for a new folder, so counts 0,..,N-1

        // Shuffle if requested...
        if (_shuffle && (_slideIndex == 0 )) _slideFiles?.shuffle();

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