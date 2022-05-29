import 'package:application_challenge/authentification/screens/reset_password.dart';
import 'package:application_challenge/authentification/screens/setting.dart';
import 'package:application_challenge/authentification/screens/signIn.dart';
import 'package:application_challenge/authentification/screens/signUp.dart';
import 'package:application_challenge/challenge/screens/photo_video_picker.dart';
import 'package:application_challenge/challenge/screens/fil_challenge.dart';
import 'package:application_challenge/challenge/screens/gallery_challenge.dart';
import 'package:application_challenge/challenge/screens/mes_challenges.dart';
import 'package:application_challenge/challenge/screens/single_challenge.dart';
// import 'package:application_challenge/contacts/screens/contact.dart';
// import 'package:application_challenge/contacts/screens/invite_contact.dart';
import 'package:application_challenge/index.dart';
import 'package:application_challenge/authentification/screens/profil.dart';
import 'package:application_challenge/notification/screens/notifications.dart';
// import 'package:application_challenge/people/screen/people_profile.dart';
import 'package:application_challenge/routeStack.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? getPages() {
  return [
    GetPage(name: '/', page: () => Index()),
    GetPage(name: '/home', page: () => RouteStack()),
    // GetPage(name: '/seePeople', page: () => PeopleProfile()),
    GetPage(name: '/setting', page: () => Setting()),
    GetPage(name: '/signup', page: () => SignUp()),
    GetPage(name: '/signin', page: () => SignIn()),
    GetPage(name: '/filChallenge', page: () => FilChallenge()),
    GetPage(name: '/myChallenge', page: () => MesChallenges()),
    GetPage(name: '/profil', page: () => Profil()),
    GetPage(name: '/challenge_gallery', page: () => GalleryChallenge()),
    GetPage(name: '/single_challenge', page: () => SingleChallenge()),
    GetPage(name: '/forgot_password', page: () => ResetPasswordScreen()),
    GetPage(name: '/notification', page: () => Notifications()),
    GetPage(name: '/create_challenge', page: () => PhotoVideoPicker()),
    // GetPage(name: '/contacts', page: () => Contacts()),
    // GetPage(name: '/invite_contact', page: () => InviteContact()),
  ];
}
