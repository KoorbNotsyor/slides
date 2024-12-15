extension Stringx on String {

  // Check if this string ends with one of those strings on the list...
  bool hasEnding(List<String> endings) {
    for (final ending in endings) {
      if (this.endsWith(ending)) {
        return true;
      }
    }
    return false;
  }

  // Check if this string represents an integer value within the given range...
  bool inRange({int minValue = 0, int maxValue = 0, bool includeMin = true, bool includeMax = true}) {
    bool _inRange = false;
    //print('inRange: value [$this] min [$minValue] max [$maxValue] include min/max [$includeMin : $includeMax]');
    int? _value = int.tryParse(this ?? '0');
    if (_value != null) {
      if ((_value > minValue) && (_value < maxValue)) {
        // Ok, closed or open interval
        _inRange = true;
     } else {
        if ((_value == minValue) && includeMin) {
          _inRange = true;
        } else if ((_value == maxValue) && includeMax) {
          _inRange = true;
        }
      }
    }
    return _inRange;
  }

}