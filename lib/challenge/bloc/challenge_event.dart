part of 'challenge_bloc.dart';

abstract class ChallengeEvent extends Equatable {
  const ChallengeEvent();

  @override
  List get props => [];
}

class OnChallengeEdition extends ChallengeEvent {
  final String displayScreen;
  OnChallengeEdition({this.displayScreen: 'gallery'});

  @override
  List get props => [displayScreen];
}

class SetPayload extends ChallengeEvent {
  final Map payload;
  SetPayload({required this.payload});

  @override
  List get props => [payload];
}

class OnLoadingPicture extends ChallengeEvent {
  final Future<File?>? imageFile;
  OnLoadingPicture({this.imageFile});

  @override
  List get props => [imageFile];
}

class OnLoadingVideo extends ChallengeEvent {
  final Future<File?>? videoFile;
  OnLoadingVideo({this.videoFile});

  @override
  List get props => [videoFile];
}

class GetVideoTrimmed extends ChallengeEvent {
  final File? videoFile;
  GetVideoTrimmed({this.videoFile});

  @override
  List get props => [videoFile];
}

// class OnSetField extends ChallengeEvent {
//   final Map? newChallengeField;
//   OnSetField({this.newChallengeField});

//   @override
//   List get props => [newChallengeField];
// }

// class OnSetDuration extends ChallengeEvent {}

// class OnSetPrivacy extends ChallengeEvent {
//   final bool? privatePrivacy;
//   OnSetPrivacy({this.privatePrivacy});

//   @override
//   List get props => [privatePrivacy];
// }

// class OnSetDuration extends ChallengeEvent {
//   final String? timeDuration;
//   OnSetDuration({this.timeDuration});

//   @override
//   List get props => [timeDuration];
// }

class OnInitState extends ChallengeEvent {}

class OnLoadingChallenge extends ChallengeEvent {
  final User user;

  OnLoadingChallenge({
    required this.user,
  });

  @override
  List get props => [user];
}

// class GetCurrentUserProfile extends ChallengeEvent {
//   final Map user;
//   final String uid;
//   GetCurrentUserProfile({required this.user, required this.uid});

//   @override
//   List get props => [this.user, this.uid];
// }

class LoadParticipatedChallenge extends ChallengeEvent {
  final String userEmail;
  LoadParticipatedChallenge({required this.userEmail});

  @override
  List get props => [userEmail];
}

class OnCreatingChallenge extends ChallengeEvent {
  final User user;
  final Map? formChallenge;
  final Map profile;
  final Map payload;
  final bool? isVideo;
  OnCreatingChallenge({
    this.isVideo,
    this.formChallenge,
    required this.user,
    required this.payload,
    required this.profile,
  });

  @override
  List get props => [
        isVideo,
        user,
        payload,
        profile,
        formChallenge,
      ];
}

class Reset extends ChallengeEvent {}

class OnClickJoinButton extends ChallengeEvent {
  final Map fromChallenge;
  OnClickJoinButton({required this.fromChallenge});

  @override
  List get props => [this.fromChallenge];
}

class OnParticipatingChallenge extends ChallengeEvent {}

class OnInputComment extends ChallengeEvent {
  final String comment;
  OnInputComment({required this.comment});

  @override
  List get props => [comment];
}

class OnLoadCommentChallenge extends ChallengeEvent {
  final String challengeId;
  OnLoadCommentChallenge({required this.challengeId});

  @override
  List get props => [challengeId];
}

class OnPostCommentChallenge extends ChallengeEvent {
  final String docId;
  final String content;
  final Map user;
  OnPostCommentChallenge({
    required this.docId,
    required this.content,
    required this.user,
  });

  @override
  List get props => [
        this.docId,
        this.content,
        this.user,
      ];
}

class OnLikeChallenge extends ChallengeEvent {
  final String challengeId;
  final String uid;

  OnLikeChallenge({required this.challengeId, required this.uid});

  @override
  List get props => [challengeId, uid];
}

class ResetChallenge extends ChallengeEvent {}

class OnLoadChildChallenge extends ChallengeEvent {
  final String challengeId;
  OnLoadChildChallenge({required this.challengeId});
  @override
  List get props => [challengeId];
}

class OnLoadMoreChallenge extends ChallengeEvent {}

class OnInviteToChallenge extends ChallengeEvent {
  final String userId;
  final Map<String, dynamic> currentUser;
  final Map<String, dynamic> challenge;
  OnInviteToChallenge(
      {required this.userId,
      required this.currentUser,
      required this.challenge});
  @override
  List get props => [userId, currentUser, challenge];
}

class RefreshInvitationList extends ChallengeEvent {}
