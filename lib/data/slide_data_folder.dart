import 'dart:io';
import 'package:slides/constants.dart';
import 'package:slides/stringx.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/control/app_state.dart';
import 'slide.dart';
import 'slide_data.dart';
import 'package:mime/mime.dart';

final RegExp reSlash = RegExp('[/\]');
final RegExp reDot = RegExp('[/.]');

// Create slide from FileSystemEntity
Slide? createSlide(FileSystemEntity fse, List<String> requestedExtensions) {
  Slide? s;
  final String path = fse.path;
  final String extension = path.split(reDot).last ?? '';
  // Check extension against list
  if (extension.isNotEmpty) {
    if (extension.toLowerCase().hasEnding(requestedExtensions)) {
      final String title =  path.split(reSlash).last ?? '';
      final String mimeType = lookupMimeType(path) ?? '';
      final bool isVideo = mimeType.toLowerCase().contains('video');//TODO FOR NOW
      s = Slide( title: title,
                  path: path,
                  mimeType: mimeType,
                  extension: extension,
                  isVideo: isVideo,
                  index: 0,
                  total: 0
                  );
      //print('$title $mimeType $isVideo');
    }
  }
  return s;
}

class SlideDataFolder implements SlideData {

  late final AppState appState;

  bool _newSlideDataFolder = true;

//  Directory? _slidesFolder;
  Directory _slidesFolder = Directory('');
  //List<String>? _slideFiles = [];
  List<Slide?> _slides = [];
  int _slideCount = 0;
  int _slideIndex = -1;
  bool _sendSlide = false;
  Slide? _s;

  bool _shuffle = false;

  SlideDataFolder() {
    appState = getIt.get<AppState>();
    _newSlideDataFolder = true;
  }

  @override
  String? getSlideSource() {
    return appState.slideShowInfo.folderPath;
  }

  @override
  Slide? getNextSlide() {
    if (_newSlideDataFolder) {
      _slides = [];
      _slidesFolder = Directory(appState.slideShowInfo.folderPath);
      List<FileSystemEntity> fse = _slidesFolder.listSync();
      if(fse.isNotEmpty) {
        final String extensions = appState.slideShowInfo.mediaTypeExtensions;
        final List<String> extensionsList = extensions.toLowerCase().decompose();
        //_slideFiles = fse.map((item) => item.path)
        //                .where((item) => item.toLowerCase().hasEnding(extensionsList))
        //                .toList(growable:false);
        _slides = fse.map((entry) {return createSlide(entry, extensionsList);})
                  .where((slide) => slide != null)
                  .toList();
      } else {
      //print('FSE[] is empty...');
      }
      _newSlideDataFolder = false;
      _slideIndex = -1; // re-set
      _shuffle = appState.slideShowInfo.shuffle;
    }

    _slideCount = _slides.length ?? 0;
    if (_slideCount > 0) {

      // Got some images... (at least 1)
      _slideIndex += 1;  // set to -1 for a new folder, so counts 0,..,N-1

      // Shuffle if requested...
      if (_shuffle && (_slideIndex == 0 )) _slides.shuffle();

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
        _s = _slides[_slideIndex];
        _s?.index = _slideIndex;
        _s?.total = _slideCount;
      }
    }
    return _s;
  }

}