part of 'authentification_bloc.dart';

abstract class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List get props => [];
}

class OnCreatedNewUser extends AuthentificationEvent {}

class ResetError extends AuthentificationEvent {}

class OnCheckUserAuth extends AuthentificationEvent {}

class SetContact extends AuthentificationEvent {
  final List contact;
  SetContact({required this.contact});

  @override
  List get props => [contact];
}

class SignUpWithEmailAndPassword extends AuthentificationEvent {
  final Map<String, String> userField;
  SignUpWithEmailAndPassword({required this.userField});

  @override
  List get props => [userField];
}

class SignInWithEmailAndPassword extends AuthentificationEvent {
  final Map<String, String> userField;
  SignInWithEmailAndPassword({required this.userField});

  @override
  List get props => [userField];
}

class SignInWithGoogle extends AuthentificationEvent {}

class SignUpWithGoogle extends AuthentificationEvent {}

class LogOut extends AuthentificationEvent {}

class ResetPassword extends AuthentificationEvent {}

class ForgotPassword extends AuthentificationEvent {}

class CreateUserProfile extends AuthentificationEvent {}

class GetUserProfile extends AuthentificationEvent {}

class UpdateUserProfile extends AuthentificationEvent {
  final Map fields;
  UpdateUserProfile({required this.fields});

  @override
  List get props => [fields];
}

class OnUpdateFieldChanges extends AuthentificationEvent {
  final Map userInfos;
  OnUpdateFieldChanges({required this.userInfos});

  @override
  List get props => [userInfos];
}

class DeleteUserProfile extends AuthentificationEvent {}

class LoadingProfileImage extends AuthentificationEvent {
  final Future<File?>? imageFile;
  final String? userId;
  LoadingProfileImage({required this.userId, this.imageFile});

  @override
  List get props => [userId, imageFile];
}

class OnEditingProfileImage extends AuthentificationEvent {}

class PatternCheck extends AuthentificationEvent {
  final bool? check;
  PatternCheck({required this.check});

  @override
  List get props => [check];
}
