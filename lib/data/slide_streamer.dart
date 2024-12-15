import 'dart:async';
import 'slide.dart';
import 'slide_data_folder.dart';
import 'package:slides/control/app_state.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/xtimers.dart';

class SlideStreamer {

  AppState appState = getIt.get<AppState>();

  final StreamController<Slide> _controller = StreamController<Slide>();
  Stream<Slide> get slideStream => _controller.stream;

  final slideData = SlideDataFolder();

  late Xtimers  _xTimer;

  bool continueStream = false;

  String? get slideSource {
    return slideData.getSlideSource();
  }

  SlideStreamer() {}

  void  setupTimers(){

    //appState.showInfo.value.display();

    int _duration = appState.showInfo.value.duration;
    int _minDuration = appState.showInfo.value.minDuration;
    int _maxDuration = appState.showInfo.value.maxDuration;
    bool _randomDurations  = appState.showInfo.value.random;

    // Set up timers according to random setting...
    if (_randomDurations) {
      _xTimer = Xtimers(minDuration: _minDuration, maxDuration: _maxDuration, payload: streamPayload);
    } else {
      _xTimer = Xtimers(minDuration: _duration, payload: streamPayload);
    }


  }

  void streamPayload() {
    Slide? s = slideData.getNextSlide();
    if (s != null) {
      _controller.sink.add(s);
    }
  }

  void startStream() async
  {
    continueStream = true;
    setupTimers();
    _xTimer.Start();
  }

  void stopStream() {
    continueStream = false;
    _xTimer.Stop();
  }

  void closeStream() {
    _controller.close();
  }

  bool get streamIsrunning {
    return continueStream;
  }
}