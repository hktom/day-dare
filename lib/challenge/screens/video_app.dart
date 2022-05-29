import 'dart:io';

import 'package:application_challenge/challenge/screens/player/multi_manager.dart';
import 'package:application_challenge/challenge/screens/player/multi_player.dart';
import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoAppPlayer extends StatefulWidget {
  final String? photoURL;
  final String? videoURL;
  final double? sizeHeight;
  VideoAppPlayer({
    Key? key,
    this.photoURL,
    this.videoURL,
    this.sizeHeight,
  }) : super(key: key);

  @override
  _VideoAppPlayerState createState() => _VideoAppPlayerState();
}

class _VideoAppPlayerState extends State<VideoAppPlayer> {
  var chewieController;

  late FlickManager flickManager;

  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickMultiManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickMultiManager.pause();
        }
      },
      child: Container(
        child: SizedBox(
          height: 380,
          child: FlickMultiPlayer(
            url: widget.videoURL!,
            flickMultiManager: flickMultiManager,
            image: widget.photoURL!,
          ),
        ),
      ),
    );
  }
}
