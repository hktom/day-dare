import 'dart:io';

import 'package:application_challenge/bloc.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
// import 'package:application_challenge/challenge/screens/video_cropper_trimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:video_compress/video_compress.dart';
// import 'package:video_trimmer/video_trimmer.dart';

import 'create_challenge.dart';
// import 'package:video_editor/video_editor.dart';
// import 'package:helpers/helpers.dart';

class VideoEditor extends StatefulWidget {
  final bool? isNew;
  VideoEditor({Key? key, this.isNew}) : super(key: key);

  @override
  _VideoEditorState createState() => _VideoEditorState();
}

class _VideoEditorState extends State<VideoEditor> {
  @override
  Widget build(BuildContext context) {
    var state = challengeBloc(context).state;

    return FutureBuilder(
        future: state.payloadVideo,
        builder: (BuildContext context, AsyncSnapshot<File?> file) {
          if (!file.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          return TrimmerView(file: file.data!, isNew: widget.isNew);
        });
  }
}

class TrimmerView extends StatefulWidget {
  final File? file;
  final bool? isNew;

  TrimmerView({Key? key, this.file, this.isNew}) : super(key: key);

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  bool isExporting = false;

  String? isError;

  // Future _compressVideo(path) async {
  //   MediaInfo? mediaInfo = await VideoCompress.compressVideo(path,
  //       quality: VideoQuality.DefaultQuality,
  //       deleteOrigin: false,
  //       includeAudio: true);
  //   return mediaInfo?.path;
  // }

  Future _getThumbnail(path) async {
    this.setState(() {
      isExporting = true;
    });

    try {
      var thumbnailFile = VideoCompress.getFileThumbnail(path,
          quality: 50, // default(100)
          position: -1 // default(-1)
          );

      this.setState(() {
        isExporting = true;
      });

      challengeBloc(context).add(OnLoadingPicture(imageFile: thumbnailFile));

      return thumbnailFile;
    } catch (e) {
      setState(() {
        isError = e.toString();
      });
    }
  }

  Future exportVideo(outPath) async {
    try {
      await _getThumbnail(outPath);
      File file = File(outPath);
      challengeBloc(context).add(GetVideoTrimmed(videoFile: file));

      Get.to(CreateChallenge(
        isNew: widget.isNew ?? false,
        isVideo: true,
      ));
    } catch (e) {
      setState(() {
        isError = e.toString();
      });
    }
  }

  Future<String?> _saveVideo() async {
    try {
      setState(() {
        _progressVisibility = true;
      });

      String path = await _trimmer.saveTrimmedVideo(
          startValue: _startValue, endValue: _endValue);

      await exportVideo(path);

      return path;
    } catch (e) {
      setState(() {
        isError = e.toString();
      });
    }
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file!);
  }

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 55,
        title: Text(
          'Editer vidéo',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: _progressVisibility
                  ? null
                  : () async {
                      try {
                        await _saveVideo();

                        // challengeBloc(context)
                        //     .add(GetVideoTrimmed(videoFile: widget.file));

                        // Get.to(CreateChallenge(
                        //   isNew: widget.isNew ?? false,
                        //   isVideo: true,
                        // ));
                      } catch (e) {
                        setState(() {
                          isError = e.toString();
                        });
                      }
                    },
              icon: FaIcon(
                FontAwesomeIcons.share,
                color: Colors.white,
              ))
        ],
      ),
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      isError ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                    Visibility(
                      visible: _progressVisibility,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: VideoViewer(trimmer: _trimmer),
                    ),
                    Center(
                      child: TrimEditor(
                        trimmer: _trimmer,
                        viewerHeight: 50.0,
                        viewerWidth: MediaQuery.of(context).size.width,
                        maxVideoLength: Duration(seconds: 10),
                        onChangeStart: (value) {
                          _startValue = value;
                        },
                        onChangeEnd: (value) {
                          _endValue = value;
                        },
                        onChangePlaybackState: (value) {
                          setState(() {
                            _isPlaying = value;
                          });
                        },
                      ),
                    ),
                    TextButton(
                      child: _isPlaying
                          ? Icon(
                              Icons.pause,
                              size: 80.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.play_arrow,
                              size: 80.0,
                              color: Colors.white,
                            ),
                      onPressed: () async {
                        bool playbackState = await _trimmer.videPlaybackControl(
                          startValue: _startValue,
                          endValue: _endValue,
                        );
                        setState(() {
                          _isPlaying = playbackState;
                        });
                      },
                    )
                  ],
                ),
                if (isExporting)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
