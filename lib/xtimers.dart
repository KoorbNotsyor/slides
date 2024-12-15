import 'dart:async';
import 'dart:math';

class Xtimers{

  int minDuration;
  int maxDuration;
  void Function()  payload;
  bool payloadFirst;

  bool _randomDurations = true;
  bool _continue = true;

  int _durationMillisecs = 0;
  Duration _duration = Duration(milliseconds: 0);

  var _random;

  Xtimers({ required this.minDuration,
            this.maxDuration = 0,       // x <= minDuration => constant duration (value minDuration) is used,
                                        // x > minDuration => random durations are used
            required this.payload,
            this.payloadFirst=false
          }) {

    // Check for random request...
    _randomDurations = maxDuration > minDuration;
    if (_randomDurations) {
      _random = Random();
    }
  }

  void Start() {
    _continue = true;
    Go();
  }

  void Go() {

    if (_continue) {

      // get required duration...
      if (_randomDurations) {
        _durationMillisecs = (minDuration + _random?.nextInt((maxDuration + 1) - minDuration)).toInt();
      } else {
        _durationMillisecs = minDuration;
      }
      _duration = Duration(milliseconds: _durationMillisecs);

      if (payloadFirst) {

        payload();
        Timer(_duration, () => Go());

      } else {

        Timer(_duration, () => Go());
        payload();

      }

    }

  }

  void Stop () {
    _continue = false;
  }

}


