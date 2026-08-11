import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/adaptive.dart' as media_kit_video_controls;
import 'package:slides/data/slide.dart';
import 'package:slides/data/slide_streamer.dart';
import 'package:slides/control/app_state.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/data/slideshow_info.dart';
import 'package:slides/constants.dart';
import 'dart:io';

import 'display_image.dart';
import 'display_video.dart';

class Front extends StatefulWidget {
  const Front({super.key});
  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {

  AppState appState = getIt.get<AppState>();

  bool _addLabel = false;
  String _slideLabel = '';

  late SlideStreamer _ss;
  String startStopText = Constants.START_SLIDE_SHOW;

  late final Player player;
  late final VideoController controller;

  navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Close...
    Navigator.pushNamed(context,route);
  }

  @override
  void initState() {
    //print('Front:initState()...');
    super.initState();

    player = Player();
    controller = VideoController(player);

    // Start streaming slides...
    _addLabel = appState.slideShowInfo.showLabel;
    _ss = SlideStreamer();
    _ss.startStream();
  }

  @override
  void dispose() {
    //print('Front:dispose()...');
    player.dispose();
    _ss.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //print('Front: build()...');

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body:
      ValueListenableBuilder<SlideshowInfo> (
        valueListenable: appState.showInfo,
        builder: (BuildContext context, _, child) {
                return StreamBuilder <Slide> (
                  initialData: null,
                  stream: _ss.slideStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Slide s = snapshot.data as Slide;
                      //print('Slide:${s.title} ${s.mimeType} ${s.isVideo}');
                      //print('Path:${s.path}');
                      if (_addLabel) {
                        _slideLabel = '${s.title} ${s.mimeType} [${s.index+1} / ${s.total}]';
                      } else {
                        _slideLabel = '';
                      }
                      return Stack(
                            children: [
                              SizedBox(
                                height: screenHeight,
                                width: screenWidth,
                                child: Center(
                                  child: (s.isVideo)
                                      ? DisplayVideo( path: s.path,
                                                      player: player,
                                                      controller: controller)
                                      : DisplayImage(path: s.path)
                                ),
                              ),

                              Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                      width: 300,
                                      child: Text(
                                          _slideLabel,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white
                                          )
                                      )
                                  )
                              ),

                              Positioned(
                                  top: 0,
                                  left: 0,
                                  height: screenHeight * 0.75,
                                  width: screenWidth,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (!_ss.streamIsrunning) {
                                          //print('START stream...[Tap]');
                                          _ss.startStream();
                                          startStopText = Constants.STOP_SLIDE_SHOW;
                                        } else {
                                          //print('STOP stream...[Tap]');
                                          _ss.stopStream();
                                          startStopText = Constants.START_SLIDE_SHOW;
                                        }
                                      });
                                    },
                                    onDoubleTap: () {
                                      setState(() {
                                        //print('STOP stream...[Double tap]');
                                        _ss.stopStream();
                                        startStopText = Constants.START_SLIDE_SHOW;
                                        navigateTo(context, '/settings');
                                      });
                                    },
                                  )

                              )
                            ]
                          );

                    } else {
                      return Stack(
                        children: [
                          SizedBox(
                            height: screenHeight,
                            width: screenWidth,
                            child: Center(
                                child: Container(
                                    height: 400, //double.infinity,
                                    width: 400, //double.infinity,
                                    color: Colors.grey,
                                    alignment: Alignment.center,
                                    child: const Text('NO SLIDE DATA')

                                )
                            ),
                          ),

                          Positioned(
                            top: 0,
                            left: 0,
                            height: screenHeight * 0.75,
                            width: screenWidth,
                            child: GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  //print('STOP stream...[Double tap]');
                                  _ss.stopStream();
                                  startStopText = Constants.START_SLIDE_SHOW;
                                  navigateTo(context, '/settings');
                                });
                              },
                            )
                          )
                        ]
                      );
                    }
            }
          );
        }
      )
   );
  }

}
