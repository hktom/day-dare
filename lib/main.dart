import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/contacts/bloc/contact_bloc.dart';
import 'package:application_challenge/people/bloc/people_bloc.dart';
import 'package:application_challenge/router.dart';
// import 'package:application_challenge/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(error);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   //Remove this method to stop OneSignal Debugging
  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  //   // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  //   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //     print("Accepted permission: $accepted");
  //   });
  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     // Will be called whenever a notification is opened/button pressed.
  //     // Capture Launch URL (App URL) here
  //     String launchUrl = "/notification";
  //   });
  //   await OneSignal.shared.setAppId("38577518-c6a7-4c88-9ae6-a435da2475e1");
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthentificationBloc>(
          create: (BuildContext context) => AuthentificationBloc(),
        ),
        BlocProvider<ChallengeBloc>(
          create: (BuildContext context) => ChallengeBloc(),
        ),
        BlocProvider<PeopleBloc>(
          create: (BuildContext context) => PeopleBloc(),
        ),
        // BlocProvider<ContactBloc>(
        //   create: (BuildContext context) => ContactBloc(),
        // ),
      ],
      child: GetMaterialApp(
        theme: themeData(),
        initialRoute: '/',
        getPages: getPages(),
      ),
    );
  }
}

ThemeData themeData() {
  return ThemeData(
    // Define the default Theme.
    accentColor: Colors.white,
    primaryColorLight: Color.fromRGBO(19, 85, 255, 1.0),
    primaryColor: Color.fromRGBO(3, 5, 52, 1.0),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    fontFamily: 'Montserrat',

    // Define the default font family.
    textTheme: TextTheme(
      subtitle1: TextStyle(
        color: Colors.black.withOpacity(.8),
      ),
      headline6: TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(.9)),
      headline5: TextStyle(
        fontSize: 14.0,
      ),
      button: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 14.0,
        color: Colors.black.withOpacity(.8),
      ),
    ),

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
  );
}
