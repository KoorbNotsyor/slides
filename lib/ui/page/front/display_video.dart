import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/adaptive.dart' as media_kit_video_controls;

class DisplayVideo extends StatefulWidget {
  final String path;
  final Player player;
  final VideoController controller;

  const DisplayVideo({  super.key,
                        required this.path,
                        required this.player,
                        required this.controller
                        });

  @override
  _DisplayVideo createState() => _DisplayVideo();
}

Future<void> loadVideo({required String path,
                        required Player player,
                        required VideoController controller
                       }) async {
  await player.setPlaylistMode(PlaylistMode.loop);
  final playable = Playlist([Media(path)],);
  await player.open(playable);
}

class _DisplayVideo extends State<DisplayVideo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadVideo( path: widget.path,
                         player:  widget.player,
                         controller:  widget.controller
                        ),
      builder: (context, snapshot) {
       if (snapshot.hasError) {
         return Container(
          color: Colors.red,
          child: const Text('OOOPS!')
         );
       }
       if(snapshot.connectionState ==ConnectionState.done) {
         return SizedBox (
            width: double.infinity,
            child: Video(
                fit: BoxFit.contain,
                fill: Colors.black,
                alignment: Alignment.center,
                controller: widget.controller,
                controls:  media_kit_video_controls.AdaptiveVideoControls //NoVideoControls, // We use custom controls
            ),
          );
       }
       return const CircularProgressIndicator();
       }
    );
  }

}