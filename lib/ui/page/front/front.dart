import 'package:flutter/material.dart';
import 'package:slides/data/slide.dart';
import 'package:slides/data/slide_streamer.dart';
import 'package:slides/control/app_state.dart';
import 'package:slides/control/service_locator.dart';
//import 'package:logger/logger.dart';
import 'package:slides/data/slideshow_info.dart';
//import 'package:slides/ui/app/drawer.dart';
import 'package:slides/constants.dart';
import 'dart:io';

class Front extends StatefulWidget {
  const Front({Key? key}) : super(key: key);
  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {

  AppState appState = getIt.get<AppState>();

  bool _addLabel = false;
  String _slideLabel = '';

  late SlideStreamer _ss;
  String startStopText = Constants.START_SLIDE_SHOW;

  navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Close...
    Navigator.pushNamed(context,route);
  }


  @override
  void initState() {
    //print('Front:initState()...');
    super.initState();
    _addLabel = appState.slideShowInfo.showLabel;
    _ss = SlideStreamer();
    _ss.startStream();
  }

  @override
  void dispose() {
    //print('Front:dispose()...');
    _ss.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //print('Front: build()...');
    //appState.showInfo.value.display();

    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Slides'),
//      ),
//      drawer: const AppDrawer(),
      body:
      Center(
        child: ValueListenableBuilder<SlideshowInfo> (
          valueListenable: appState.showInfo,
          builder: (BuildContext context, _, child) {
                return ListView(
                children: [

//                  const SizedBox(height: 10,),
//
//                  Text(_ss.slideSource ?? '',
//                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
//
//                  const SizedBox(height: 10,),

/*                  ElevatedButton(onPressed: () {
                    // Start or Stop...
                    setState(() {
                      if (!_ss.streamIsrunning) {
                        _ss.startStream();
                        startStopText = Constants.STOP_SLIDE_SHOW;
                      } else {
                        _ss.stopStream();
                        startStopText = Constants.START_SLIDE_SHOW;
                      }
                    });
                    }, child: Text(startStopText)
                  ),
*/
//                  const SizedBox(height: 10,),

                  StreamBuilder <Slide> (
                    initialData: null,
                    stream: _ss.slideStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Slide s = snapshot.data as Slide;
                        //print('Slide:${s.getTitle} path [${s.getPath}]');
                        if (_addLabel) {
                          _slideLabel = '${s.getTitle} [${s.index+1} / ${s.total}]';
                        } else {
                          _slideLabel = '';
                        }
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                  if (!_ss.streamIsrunning) {
//                                    print('START strem...[Tap]');
                                    _ss.startStream();
                                    startStopText = Constants.STOP_SLIDE_SHOW;
                                  } else {
//                                    print('STOP stream...[Tap]');
                                    _ss.stopStream();
                                    startStopText = Constants.START_SLIDE_SHOW;
                                  }
                                }
                              );
                            },
                            onDoubleTap: () {
                              setState(() {
//                                  print('STOP stream...[Double tap]');
                                  _ss.stopStream();
                                  startStopText = Constants.START_SLIDE_SHOW;
                                  navigateTo(context, '/settings');
                                }
                              );
                            },
                            child: Stack(

                              children: [

                                Container(
                                  //height: double.infinity,
                                  width: double.infinity,

                                  child: Image.file(
                                      File(s.getPath),
                                      gaplessPlayback: true,
                                      fit: BoxFit.contain //BoxFit.fitHeight //BoxFit.cover //BoxFit.contain,
                                  )

                                ),

                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                      width: 300,
                                      child: Text(
                                        _slideLabel,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white
                                        )
                                      )
                                  )
                                )

                              ]
                            )

                            );

                      } else {

                        return GestureDetector(
                            onDoubleTap: () {
                              setState(() {
//                                print('NO DATA - STOP stream...[Double tap]');
                                _ss.stopStream();
                                startStopText = Constants.START_SLIDE_SHOW;
                                navigateTo(context, '/settings');
                              }
                              );
                            },
                            child: Container(
                              height: 400, //double.infinity,
                              width: 400, //double.infinity,
                              color: Colors.grey,
                              alignment: Alignment.center,
                              child: Text('NO SLIDE DATA')

                            ));

                      }

                    }
                  ),

                ],
                );
          }
      ),
    )
   );
  }

}
