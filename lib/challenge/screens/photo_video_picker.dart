import 'dart:io';
import 'dart:typed_data';

import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/challenge/screens/create_challenge.dart';
import 'package:application_challenge/challenge/screens/video_edition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../bloc.dart';

class PhotoVideoPicker extends StatelessWidget {
  final bool? isNew;
  final bool? uploadChallenge;
  const PhotoVideoPicker({Key? key, this.isNew, this.uploadChallenge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    challengeBloc(context).add(Reset());
    // challengeBloc(context).add(OnChallengeEdition(displayScreen: 'gallery'));
    return BlocBuilder<ChallengeBloc, ChallengeState>(
      builder: (context, state) {
        return MobileGallery(
          uploadChallenge: uploadChallenge ?? true,
          isNew: isNew,
        );
      },
    );
  }
}

class MobileGallery extends StatefulWidget {
  final bool? uploadChallenge;
  final bool? isNew;
  MobileGallery({Key? key, this.isNew, this.uploadChallenge}) : super(key: key);

  @override
  _MobileGalleryState createState() => _MobileGalleryState();
}

class _MobileGalleryState extends State<MobileGallery> {
  List<AssetEntity> assets = [];

  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  _fetchAssets() async {
    var result = await PhotoManager.requestPermissionExtend();

    if (result.isAuth) {
      final albums = await PhotoManager.getAssetPathList(onlyAll: true);
      final recentAlbum = albums.first;

      final recentAssets = await recentAlbum.getAssetListRange(
        start: 0,
        end: 10000,
      );

      setState(() => assets = recentAssets);
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 55,
        title: Text('Gallery', style: TextStyle(color: Colors.white)),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: assets.length,
        itemBuilder: (_, index) {
          return mobileGalleryImage(
            context,
            isNew: widget.isNew,
            uploadChallenge: widget.uploadChallenge,
            asset: assets[index],
          );
        },
      ),
    );
  }
}

Widget mobileGalleryImage(
  context, {
  AssetEntity? asset,
  bool? uploadChallenge,
  bool? isNew,
}) {
  AuthentificationState state = authentificationBloc(context).state;
  return FutureBuilder<Uint8List?>(
    future: asset!.thumbData,
    builder: (_, snapshot) {
      final bytes = snapshot.data;

      if (bytes == null)
        return Container(
          height: 25,
          child: Center(
              child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          )),
        );

      return InkWell(
        onTap: () {
          _onSelectItem(
            context,
            isNew: isNew,
            state: state,
            asset: asset,
            uploadChallenge: uploadChallenge,
          );
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.memory(bytes, fit: BoxFit.cover),
            ),
            if (asset.type == AssetType.video)
              Center(
                child: Container(
                  color: Colors.blue,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}

void _onSelectItem(
  context, {
  state,
  asset,
  bool? uploadChallenge,
  bool? isNew,
}) {
  if (asset.type == AssetType.image) {
    if (uploadChallenge == true) {
      challengeBloc(context).add(OnLoadingPicture(imageFile: asset.file));
      Get.to(CreateChallenge(isNew: isNew ?? false));
    }
    if (uploadChallenge == false) {
      authentificationBloc(context).add(LoadingProfileImage(
          imageFile: asset.file, userId: state.user!.email));
      Get.back();
      return;
    }
  }

  if (asset.type == AssetType.video) {
    challengeBloc(context).add(OnLoadingVideo(videoFile: asset.file));
    Get.to(VideoEditor(isNew: isNew ?? false));
  }
}
