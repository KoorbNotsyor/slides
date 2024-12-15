import 'slide.dart';

abstract class SlideData {

  String? getSlideSource();

  // Return a SLide (with sufficient info to display immage or NULL
  Slide? getNextSlide();

}