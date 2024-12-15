import 'slide.dart';
import 'slide_data.dart';

 class SlideDataList implements SlideData {

   int streamIdx = 0;

   // a list of slides...
   final List<Slide> data = [
     //Slide(title: "Image 1", url: "https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg"),
     //Slide(title: "Image 2", url: "https://www.kindacode.com/wp-content/uploads/2022/07/flower-4.jpeg"),
     //Slide(title: "Image 3", url: "https://www.kindacode.com/wp-content/uploads/2022/07/flower-3.jpeg"),
     //Slide(title: "Image 4", url: "https://www.kindacode.com/wp-content/uploads/2022/07/flower-1.jpeg"),
     //Slide(title: "Image 5", url: "https://cdn.pixabay.com/photo/2020/04/19/12/26/thread-5063401_960_720.jpg"), // !!! won't display, downloads...
     //Slide(title: "Image 5", url: "https://www.kindacode.com/wp-content/uploads/2022/07/bottle.jpeg"),
     //Slide(title: "Image 6", url: "https://www.kindacode.com/wp-content/uploads/2022/07/flower-2.jpeg"),
   ];

   String? getSlideSource() {
     return 'FIXED LIST';
   }

   Slide getNextSlide() {
    Slide s =  data[streamIdx];
    streamIdx = (streamIdx + 1).remainder(data.length);
    return s;
  }

}