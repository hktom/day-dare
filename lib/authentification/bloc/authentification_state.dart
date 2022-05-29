part of 'authentification_bloc.dart';

class AuthentificationState extends Equatable {
  final List? contact;
  final Map? userProfile;
  final User? user;
  final int? status;
  final int? initialScreen;
  final String? error;
  final List? followers;
  final List? followings;
  const AuthentificationState(
      {this.contact,
      this.user,
      this.status,
      this.initialScreen,
      this.error,
      this.userProfile,
      this.followers,
      this.followings});

  AuthentificationState copyWith({
    List? followers,
    List? followings,
    List? contact,
    User? user,
    int? status,
    String? error,
    int? initialScreen,
    Map? userProfile,
  }) {
    return AuthentificationState(
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      contact: contact ?? this.contact,
      user: user ?? this.user,
      status: status ?? this.status,
      initialScreen: initialScreen ?? this.initialScreen,
      error: error ?? this.error,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List get props => [
        user,
        status,
        error,
        initialScreen,
        userProfile,
        contact,
        followers,
        followings,
      ];
}

// class AuthentificationInitial extends AuthentificationState {}
