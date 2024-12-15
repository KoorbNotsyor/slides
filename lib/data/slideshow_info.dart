
class SlideshowInfo {

  String _folderPath = '';      // folder containing slide images
  int _duration = 1000;         // duration for interval between each slide in ms
  int _minDuration = 50;        // minimum interval duration [NOT USED]
  int _maxDuration = 10000;     // maximum interval duration [NOT USED]
  bool _repeat = false;         // repeat at end
  bool _random = false;         // generate random intervals between slides
  int _fade = 0;                // fade-in time ms [NOT USED]
  bool _showLabel = false;      // display label with slide

  bool _newFolder = true;

  SlideshowInfo();

  SlideshowInfo.copy(SlideshowInfo ssi) {
    _folderPath =  ssi.folderPath;
    _duration = ssi.duration;
    _minDuration = ssi.minDuration;
    _maxDuration = ssi.maxDuration;
    _repeat = ssi.repeat;
    _random = ssi.random;
    _fade = ssi.fade;
    _showLabel = ssi.showLabel;
    _newFolder = ssi._newFolder;
  }

  SlideshowInfo.fromJson(Map<String, dynamic> json)
      : _folderPath =  json['folderPath'],
        _duration = json['duration'],
        _minDuration = json['minDuration'],
        _maxDuration = json['maxDuration'],
        _repeat = json['repeat'],
        _random = json['random'],
        _fade = json['fade'],
        _showLabel = json['showLabel'];

  Map<String, dynamic> toJson() =>
      {
        'folderPath': _folderPath,
        'duration': _duration,
        'minDuration': _minDuration,
        'maxDuration': _maxDuration,
        'repeat': _repeat,
        'random': _random,
        'fade': _fade,
        'showLabel': _showLabel
      };

  fromJson(Map<String, dynamic> json) {
    _folderPath =  json['folderPath'];
    _duration = json['duration'];
    _minDuration = json['minDuration'];
    _maxDuration = json['maxDuration'];
    _repeat = json['repeat'];
    _random = json['random'];
    _fade = json['fade'];
    _showLabel = json['showLabel'];
    _newFolder = true;
  }

  String get folderPath => _folderPath;
  set folderPath(String? path) => _folderPath = path ?? '';

  int get duration => _duration;
  set duration(nmillisecs) => _duration = nmillisecs;

  int get minDuration => _minDuration;
  set minDuration(nmillisecs) => _minDuration = nmillisecs;

  int get maxDuration => _maxDuration;
  set maxDuration(nmillisecs) => _maxDuration = nmillisecs;

  bool get repeat => _repeat;
  set repeat(continous) => _repeat = continous;

  bool get random => _random;
  set random(random) => _random = random;  int get fade => _fade;
  set fade(nmillisecs) => _fade = nmillisecs;

  bool get showLabel => _showLabel;
  set showLabel(showLabel) => _showLabel = showLabel;

  bool get newFolder => _newFolder;
  set newFolder(bool isNew) => _newFolder = isNew;

  bool hasFolderPath() {
    return _folderPath.isNotEmpty;
  }

  void display() {
    print('SlideshowInfo:duration[$duration]ms min/max[$minDuration,$maxDuration] repeat[$repeat] random[$random] fade[$fade] show[$showLabel] folder[$folderPath] new[$newFolder]');
  }

}