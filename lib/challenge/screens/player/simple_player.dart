import 'dart:io';

import 'package:application_challenge/challenge/screens/player/multi_manager.dart';
import 'package:application_challenge/challenge/screens/player/portrait_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SimplePlayer extends StatefulWidget {
  final File video;
  SimplePlayer({Key? key, required this.video}) : super(key: key);

  @override
  _SimplePlayerState createState() => _SimplePlayerState();
}

class _SimplePlayerState extends State<SimplePlayer> {
  FlickManager? flickManager;
  FlickMultiManager flickMultiManager = FlickMultiManager();
  String? error;

  @override
  void initState() {
    try {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.file(widget.video),
      );

      flickMultiManager.init(flickManager!);
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    flickManager!.dispose();
    flickMultiManager.remove(flickManager!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Container(
        height: 300,
        width: double.infinity,
        color: Colors.grey.shade100,
        child: Center(
          child: Text(error ?? ''),
        ),
      );
    }
    return Container(
      height: 300,
      child: SizedBox(
        height: 300,
        child: Container(
          child: FlickVideoPlayer(
            flickManager: flickManager!,
            flickVideoWithControls: FlickVideoWithControls(
              videoFit: BoxFit.contain,
              controls: FeedPlayerPortraitControls(
                flickMultiManager: flickMultiManager,
                flickManager: flickManager,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
