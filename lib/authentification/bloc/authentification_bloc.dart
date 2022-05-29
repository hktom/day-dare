import 'dart:async';
import 'dart:io';

import 'package:application_challenge/authentification/data/authentification_repository.dart';
import 'package:application_challenge/utils/image_upload_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  AuthentificationBloc() : super(AuthentificationState());
  AuthentificationRepository authentificationRepository =
      AuthentificationRepository();

  @override
  Stream<AuthentificationState> mapEventToState(
    AuthentificationEvent event,
  ) async* {
    AuthentificationState authentificationState = new AuthentificationState(
        contact: state.contact,
        user: state.user,
        status: state.status,
        error: state.error,
        initialScreen: state.initialScreen,
        userProfile: state.userProfile);
    // check userAuth

    if (event is SetContact)
      yield authentificationState.copyWith(contact: event.contact);

    if (event is ResetError)
      yield authentificationState.copyWith(error: 'null', status: 0);

    if (event is OnCheckUserAuth) {
      User? user = await authentificationRepository.checkUserAuth();

      // not connected
      if (user == null) {
        yield authentificationState.copyWith(status: 404, initialScreen: 0);
        return;
      }

      Map? profile = await _getProfile(user);

      if (profile == null) {
        yield* _createUser(authentificationState, user, {
          'displayName': user.displayName,
          'email': user.email,
        });
      } else {
        yield authentificationState.copyWith(
          user: user,
          status: 200,
          userProfile: profile,
        );
        Get.offAllNamed('/home');
      }
    }

    if (event is SignInWithEmailAndPassword) {
      // start connection
      yield authentificationState.copyWith(status: 100, error: 'null');
      User? userCredential =
          await authentificationRepository.signInWithEmailAndPassword(
        email: event.userField["email"]!,
        password: event.userField["password"]!,
      );

      // authentification failed or credential not found
      if (userCredential == null) {
        yield authentificationState.copyWith(
          status: 404,
          error: "L'email ou le mot de passe n'est pas correcte",
        );
        return;
      }

      // credential found
      Map? userFIeld = await authentificationRepository.getUserProfile(
          userCredential: userCredential);

      if (userFIeld == null) {
        yield authentificationState.copyWith(
            status: 500, error: "Une erreur s'est produite");
        return;
      }

      // signin successfully
      yield authentificationState.copyWith(
          user: userCredential, userProfile: userFIeld, status: 200);
      // redirect to home
      Get.offAllNamed('/home');
    }

    // signin with google and signup
    if (event is SignInWithGoogle || event is SignUpWithGoogle) {
      yield authentificationState.copyWith(status: 100);
      User? userCredential =
          await authentificationRepository.signInWithGoogle();

      // authentification google failed
      if (userCredential == null) {
        yield authentificationState.copyWith(
            error: "Une erreur s'est produite",
            status: event is SignInWithGoogle ? 404 : 403);
        return;
      }

      // get profile
      Map? userFIeld = await authentificationRepository.getUserProfile(
          userCredential: userCredential);

      if (userFIeld == null) {
        yield* _createUser(authentificationState, userCredential, {
          'displayName': userCredential.displayName ?? 'no pseudo',
          'email': userCredential.email,
        });
        return;
      }

      // authentification google succeed
      yield authentificationState.copyWith(
        user: userCredential,
        userProfile: {...userFIeld, 'id': userCredential.email},
        status: 200,
        error: '',
      );

      // redirect to home
      Get.offAllNamed('/home');
    }

    // signupWithEmailAndPassword
    if (event is SignUpWithEmailAndPassword) {
      // start connection
      yield authentificationState.copyWith(status: 100, error: '');

      // create auth_user
      User? user =
          await authentificationRepository.createUserWithEmailAndPassword(
        email: event.userField["email"]!,
        password: event.userField["password"]!,
      );

      if (user != null)
        yield* _createUser(authentificationState, user, event.userField);
      else
        yield authentificationState.copyWith(
          status: 503,
          error: "Il semble que ce compte existe déjà",
        );
    }

    if (event is LogOut) {
      await authentificationRepository.signOut();
      yield authentificationState.copyWith(status: 0, initialScreen: 0);
      Get.offAllNamed('/');
    }

    if (event is UpdateUserProfile) {
      await authentificationRepository.updateUser(
        userInfos: {...state.userProfile!, ...event.fields},
      );

      Map? profile = await _getProfile(state.user!);
      yield authentificationState.copyWith(
        userProfile: {...profile!, 'id': state.user!.email},
      );
    }

    if (event is OnEditingProfileImage) {
      // yield authentificationState
      //     .copyWith(user: {...state.user, "editingImage": true});
    }

    if (event is LoadingProfileImage) {
      File? _file = await event.imageFile;
      String? _imageURL = await uploadImage(file: _file!, isImage: true);
      Map _userField = state.userProfile!;
      _userField['photoURL'] = _imageURL;

      await authentificationRepository.updateUser(userInfos: _userField);
      yield authentificationState.copyWith(userProfile: _userField);
    }

    if (event is ResetPassword) {
      // print('validate ${state.user["userField"]["email"]}');
      // // return;
      // bool data = await authentificationRepository.resetPassword(
      //     email: state.user["userField"]["email"]);

      // if (data == false) {
      //   yield authentificationState.copyWith(user: {
      //     ...state.user,
      //     'resetError': "L'email n'est pas valide.",
      //   });
      //   return;
      // }
      // yield authentificationState.copyWith(user: {
      //   ...state.user,
      //   'resetSuccess': true,
      // });
    }
  }

  Future<Map?> _getProfile(User user) async {
    Map? profile = await authentificationRepository.getUserProfile(
      userCredential: user,
    );

    return profile;
  }

  Stream<AuthentificationState> _createUser(
    AuthentificationState authentificationState,
    User user,
    Map myprofile,
  ) async* {
    bool? userHasBeenCreated = await authentificationRepository
        .createUserProfile(user: user, profile: myprofile);

    if (userHasBeenCreated == false) {
      yield authentificationState.copyWith(
        status: 305,
        error: "Une erreur s'est produite, vérifiez votre connexion.",
      );

      return;
    }

    Map? profile = await _getProfile(user);

    yield authentificationState.copyWith(
      status: 200,
      error: '',
      user: user,
      userProfile: profile,
    );
    Get.offAllNamed('/home');
  }
}
