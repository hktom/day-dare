import 'dart:async';
import 'dart:io';
// import 'package:application_challenge/challenge/data/challenge_model.dart';
import 'package:application_challenge/challenge/data/challenge_repository.dart';
import 'package:application_challenge/utils/image_upload_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'challenge_event.dart';
part 'challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  ChallengeBloc() : super(ChallengeState());
  ChallengeRepository challengeRepository = ChallengeRepository();

  @override
  Stream<ChallengeState> mapEventToState(
    ChallengeEvent event,
  ) async* {
    ChallengeState challengeState = new ChallengeState(
      byMe: state.byMe,
      private: state.private,
      onGoing: state.onGoing,
      progression: state.progression,
      expired: state.expired,
      page: state.page,
      payloadImage: state.payloadImage,
      payloadVideo: state.payloadVideo,
      payloadVideoTrimmed: state.payloadVideoTrimmed,
      children: state.children,
      participated: state.participated,
      payload: state.payload,
    );

    if (event is Reset) {
      ChallengeState(
        byMe: state.byMe,
        private: state.private,
        onGoing: state.onGoing,
        progression: state.progression,
        expired: state.expired,
        children: state.children,
        participated: state.participated,
      );
    }

    if (event is ResetChallenge) yield ChallengeState();

    if (event is SetPayload)
      yield challengeState.copyWith(payload: event.payload);

    if (event is OnLoadingChallenge) {
      yield* _loadChallenges(challengeState, event.user.email);
    }

    if (event is LoadParticipatedChallenge) {
      List? data =
          await challengeRepository.getParticipatedChallenges(event.userEmail);

      yield challengeState.copyWith(participated: data ?? []);
    }

    if (event is GetVideoTrimmed)
      yield challengeState.copyWith(payloadVideoTrimmed: event.videoFile);

    if (event is OnLoadingPicture)
      yield challengeState.copyWith(payloadImage: event.imageFile);

    if (event is OnLoadingVideo)
      yield challengeState.copyWith(payloadVideo: event.videoFile);

    if (event is OnCreatingChallenge) {
      yield challengeState.copyWith(progression: true);

      String? imageURL = await _uploadImage(state.payloadImage);

      String? videoURL = state.payloadVideoTrimmed != null
          ? await _uploadVideo(state.payloadVideoTrimmed!)
          : null;

      if (imageURL == 'null') return;

      var status = event.formChallenge == null
          ? await _postChallenge(event, imageURL, videoURL)
          : await _joinChallenge(event, imageURL, videoURL);

      if (status == null || status == false) {}

      yield* _loadChallenges(challengeState, event.user.email);
    }

    if (event is OnLikeChallenge) {
      await challengeRepository.toggleLikeChallenge(
        challengeId: event.challengeId,
        uid: event.uid,
      );
    }

    if (event is OnPostCommentChallenge) {
      await challengeRepository.postComments(
        user: event.user,
        docId: event.docId,
        content: event.content,
      );
    }

    if (event is OnClickJoinButton) {
      // yield ChallengeState(challenges: {
      //   ...state.challenges,
      //   'fromChallenge': event.fromChallenge
      // });
    }

    if (event is OnLoadChildChallenge) {
      // yield ChallengeState(
      //     challenges: {...state.challenges, 'loadingChildChallenge': true});
      List? challenges;
      await challengeRepository
          .getChildChallenges(event.challengeId)
          .then((value) {
        challenges = value;
      });

      if (challenges == null) {
        return;
      }

      yield challengeState.copyWith(children: challenges);
    }

    // if (event is OnInviteToChallenge) {
    //   bool? _data = await challengeRepository.onInviteToChallenge(
    //       userId: event.userId,
    //       challenge: event.challenge,
    //       currentUser: event.currentUser);
    //   if (_data == false || _data == null) {
    //     // Map _error = {"error": "Une invitation n'a pas été envoyée"};
    //     // yield ChallengeState(
    //     //     challenges: {...state.challenges, "invitationError": _error});
    //     // return;
    //   }

    //   // List? _invitationList = state.challenges["invitationList"] ?? [];
    //   // _invitationList!.add(event.userId);
    //   // yield ChallengeState(challenges: {
    //   //   ...state.challenges,
    //   //   "invitationList": _invitationList,
    //   //   "invitationError": null,
    //   // });
    // }

    // if (event is RefreshInvitationList) {
    //   //   yield ChallengeState(
    //   //       challenges: {...state.challenges, "invitationList": []});
    // }
  }

  bool? challengeAvailablity(Map challenge) {
    Duration _duration = getRemainingTime(
      date: challenge["date"],
      duration: challenge["duration"] ?? 0,
    );
    String _elapsedTimes = getAvailablity(_duration);
    return _elapsedTimes != '-' ? true : false;
  }

  // int getDurationFromChallege(Map? challenge) {
  //   Map? _parentChallenge = challenge!['fromChallenge'];
  //   int? _duration = _parentChallenge!['duration'];
  //   while (_duration == null) {
  //     _parentChallenge = _parentChallenge!['fromChallenge'];
  //     _duration = _parentChallenge!['duration'];
  //   }
  //   return _duration;
  // }

  Future<String?> _postChallenge(
      OnCreatingChallenge event, String? imageURL, String? videoURL) async {
    String? challengeId = await challengeRepository.postChallenge(
      challenge: event.payload,
      user: event.profile,
      videoURL: videoURL,
      imageURL: imageURL,
    );

    return challengeId;
  }

  Future<bool> _joinChallenge(
      OnCreatingChallenge event, String? imageURL, String? videoURL) async {
    bool value = await challengeRepository.joinChallenge(
      fromChallenge: event.formChallenge!,
      challenge: event.payload,
      user: event.profile,
      imageURL: imageURL,
      videoURL: videoURL,
    );
    return value;
  }

  Future<String?> _uploadImage(image) async {
    String imageURL = await uploadImage(file: await image, isImage: true);

    return imageURL;
  }

  Future<String?> _uploadVideo(File video) async {
    String imageURL = await uploadImage(
      file: video,
      isImage: false,
    );

    return imageURL;
  }

  Stream<ChallengeState> _loadChallenges(
      ChallengeState challengeState, userEmail) async* {
    List? challenges = await challengeRepository.getChallenges();

    List onGoing = [];
    List private = [];
    List expired = [];

    if (challenges == null || challenges.isEmpty) {
      yield challengeState.copyWith(
        private: [],
        onGoing: [],
        expired: [],
        progression: false,
        payload: {},
      );
      return;
    }

    try {
      challenges.forEach((e) {
        if (!e['isPrivate']) {
          if (challengeAvailablity(e) == true)
            onGoing.add({...e, 'valide': true});
          else
            expired.add({...e, 'valide': false});
        } else {
          // List groupe = e['groupe'];
          List userFound =
              e['groupe'].where((user) => user['id'] == userEmail).toList();
          if (challengeAvailablity(e) == true && userFound.isNotEmpty)
            private.add({...e, 'valide': true});

          if (challengeAvailablity(e) != true && userFound.isNotEmpty)
            expired.add({...e, 'valide': false});
        }
      });
    } catch (e) {
      print('******************Error loading challenge $e');
    }

    yield challengeState.copyWith(
      private: private,
      onGoing: onGoing,
      expired: expired,
      progression: false,
      payload: {},
    );
  }
}
