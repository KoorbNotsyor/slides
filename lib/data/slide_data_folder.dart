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

  final _reSlash = RegExp('[/\]');

  SlideDataFolder() {
    appState = getIt.get<AppState>();
    _newSlideDataFolder = true;
  }

  String? getSlideSource() {
    print('Folder[${appState.slideShowInfo.folderPath}]');
    return appState.slideShowInfo.folderPath;
  }

  Slide? getNextSlide() {

    /*
    if (_newSlideDataFolder) {
      _slidesFolder = new Directory(appState.slideShowInfo.folderPath);
      print('Folder[${appState.slideShowInfo.folderPath}]');
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
    */

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
      //print('Folder[${appState.slideShowInfo.folderPath}]');
      List<FileSystemEntity> fse = _slidesFolder.listSync();
      if(fse.isNotEmpty) {
        //print('FSE[] not empty...');
        //fse.forEach((entry) {
        //  print('+path[${entry.path}]');
        //});
        _slideFiles = fse.map((item) => item.path)
                        .where((item) => item.hasEnding(Constants.IMAGE_FILE_EXTENSIONS))
                        .toList(growable:false);
      } else {
        //print('FSE[] is empty...');
      }
      _newSlideDataFolder = false;
      _slideIndex = -1; // re-set
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