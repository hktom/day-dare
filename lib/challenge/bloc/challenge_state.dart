part of 'challenge_bloc.dart';

class ChallengeState extends Equatable {
  // final Map challenges;
  final Map? payload;
  final List? byMe;
  final List? participated;
  final List? children;
  final List? expired;
  final List? onGoing;
  final List? private;
  final bool? progression;
  final int? page;
  final int? screen;
  final Future<File?>? payloadImage;
  final Future<File?>? payloadVideo;
  final File? payloadVideoTrimmed;

  const ChallengeState({
    this.participated,
    this.payload,
    this.byMe,
    this.children,
    this.expired,
    this.onGoing,
    this.progression,
    this.private,
    this.page,
    this.payloadImage,
    this.payloadVideo,
    this.screen,
    this.payloadVideoTrimmed,
  });

  ChallengeState copyWith({
    List? participated,
    List? byMe,
    List? children,
    List? expired,
    List? onGoing,
    List? private,
    bool? progression,
    int? page,
    int? screen,
    Map? payload,
    Future<File?>? payloadImage,
    Future<File?>? payloadVideo,
    File? payloadVideoTrimmed,
  }) {
    return ChallengeState(
      participated: participated ?? this.participated,
      payload: payload ?? this.payload,
      byMe: byMe ?? this.byMe,
      children: children ?? this.children,
      expired: expired ?? this.expired,
      onGoing: onGoing ?? this.onGoing,
      private: private ?? this.private,
      progression: progression ?? this.progression,
      page: page ?? this.page,
      payloadImage: payloadImage ?? this.payloadImage,
      payloadVideo: payloadVideo ?? this.payloadVideo,
      payloadVideoTrimmed: payloadVideoTrimmed ?? this.payloadVideoTrimmed,
      screen: screen ?? this.screen,
    );
  }

  @override
  List get props => [
        participated,
        payload,
        byMe,
        children,
        expired,
        onGoing,
        progression,
        private,
        page,
        payloadImage,
        payloadVideo,
        screen,
        payloadVideoTrimmed
      ];
}
