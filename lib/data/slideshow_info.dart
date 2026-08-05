
class SlideshowInfo {

  String _folderPath = '';          // folder containing slide images
  String _mediaTypeExtensions = ''; // will default to constant IMAGE_FILE_EXTENSIONS
  int _duration = 1000;             // duration for interval between each slide in ms
  int _minDuration = 50;            // minimum interval duration (for random intervals)
  int _maxDuration = 10000;         // maximum interval duration (for random Intervals)
  bool _shuffle = false;            // shuffle slides
  bool _repeat = false;             // repeat at end
  bool _random = false;             // generate random intervals between slides
  int _fade = 0;                    // fade-in time ms [NOT USED]
  bool _showLabel = false;          // display label with slide

  bool _newFolder = true;

  SlideshowInfo();

  SlideshowInfo.copy(SlideshowInfo ssi) {
    _folderPath =  ssi.folderPath;
    _mediaTypeExtensions = ssi.mediaTypeExtensions;
    _duration = ssi.duration;
    _minDuration = ssi.minDuration;
    _maxDuration = ssi.maxDuration;
    _shuffle = ssi.shuffle;
    _repeat = ssi.repeat;
    _random = ssi.random;
    _fade = ssi.fade;
    _showLabel = ssi.showLabel;
    _newFolder = ssi._newFolder;
  }

  SlideshowInfo.fromJson(Map<String, dynamic> json)
      : _folderPath =  json['folderPath'],
        _mediaTypeExtensions = json['mediaTypeExtensions'],
        _duration = json['duration'],
        _minDuration = json['minDuration'],
        _maxDuration = json['maxDuration'],
        _shuffle = json['shuffle'],
        _repeat = json['repeat'],
        _random = json['random'],
        _fade = json['fade'],
        _showLabel = json['showLabel'];

  Map<String, dynamic> toJson() =>
      {
        'folderPath': _folderPath,
        'mediaTypeExtensions': _mediaTypeExtensions,
        'duration': _duration,
        'minDuration': _minDuration,
        'maxDuration': _maxDuration,
        'shuffle': _shuffle,
        'repeat': _repeat,
        'random': _random,
        'fade': _fade,
        'showLabel': _showLabel
      };

  fromJson(Map<String, dynamic> json) {
    _folderPath =  json['folderPath'];
    _mediaTypeExtensions = json['mediaTypeExtensions'];
    _duration = json['duration'];
    _minDuration = json['minDuration'];
    _maxDuration = json['maxDuration'];
    _shuffle = json['shuffle'];
    _repeat = json['repeat'];
    _random = json['random'];
    _fade = json['fade'];
    _showLabel = json['showLabel'];
    _newFolder = true;
  }

  String get folderPath => _folderPath;
  set folderPath(String? path) => _folderPath = path ?? '';

  String get mediaTypeExtensions => _mediaTypeExtensions;
  set mediaTypeExtensions(String? values) => _mediaTypeExtensions = values ?? '';

  int get duration => _duration;
  set duration(nmillisecs) => _duration = nmillisecs;

  int get minDuration => _minDuration;
  set minDuration(nmillisecs) => _minDuration = nmillisecs;

  int get maxDuration => _maxDuration;
  set maxDuration(nmillisecs) => _maxDuration = nmillisecs;

  bool get shuffle => _shuffle;
  set shuffle(mix) => _shuffle = mix;

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

  void display(String id) {
    print('SlideshowInfo $id <');
    print('-folderPath [$folderPath]');
    print('-mediaTypeExtensions [$mediaTypeExtensions]');
    print('-duration  [$duration]');
    print('-minDuration [$minDuration]');
    print('-maxDuration [$maxDuration]');
    print('-shuffle [$shuffle]');
    print('-repeat [$repeat]');
    print('-random [$random]');
    print('-fade [$fade]');
    print('-showLabel [$showLabel]');
    print('-newFolder [$newFolder]');
    print('>');
 }

}