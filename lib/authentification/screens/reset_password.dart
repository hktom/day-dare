import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/authentification/screens/view/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, TextEditingController> _controller = {
    'name': new TextEditingController(),
    'email': new TextEditingController(),
    'password': new TextEditingController(),
    'password_confirm': new TextEditingController(),
  };

  @override
  void initState() {
    authentificationBloc(context).add(ResetError());
    super.initState();
  }

  /*
  state.user['resetSuccess']
                  ? _succesWidget(context, state.user['userField']['email'])
                  : 
  */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<AuthentificationBloc, AuthentificationState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: size.width * 100,
            height: size.height * 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  _infos(context),
                  _formWidget(
                    context,
                    _formKey,
                    size: size,
                    controller: _controller,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _header(context) {
  return Container(
    margin: EdgeInsets.only(top: 50),
    alignment: Alignment.centerLeft,
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _headerText(context, "Mot de passe"),
        _headerText(context, "Oublié"),
      ],
    ),
  );
}

Widget _formWidget(context, _formKey,
    {Size? size, Map<String, TextEditingController>? controller}) {
  return BlocBuilder<AuthentificationBloc, AuthentificationState>(
    builder: (context, state) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // echec authentication
            if (state.error != null && state.error != 'null')
              fieldError(context, state.error),
            emailField(context, size, state, controller: controller!['email']!),
            Container(
                width: 180,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Get.snackbar("", "forma validate");
                        // if (state.user["status"] == 100) return null;
                        print('form validate');
                        authentificationBloc(context).add(ResetPassword());
                        // authentificationBloc(context)
                        //     .add(SignInWithEmailAndPassword());
                        if (state.status == 100) return null;
                        print('post validate');
                      }
                    },
                    child: Text("Envoyer",
                        style: Theme.of(context).textTheme.button!.copyWith(
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center))),
          ],
        ),
      );
    },
  );
}

Widget _headerText(context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.black.withOpacity(.9),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
    textAlign: TextAlign.left,
  );
}

Widget _infos(context) {
  return Text(
    'Un mail de reinitialisation de mot de vous serez envoyé, veuillez entrez l\'email pour reinitialiser.',
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
    textAlign: TextAlign.left,
  );
}

PreferredSize _appBar(context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(55.5),
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black.withOpacity(.7),
            ),
            onPressed: () {
              Get.toNamed('/signin');
            },
            tooltip: 'Retour',
          );
        },
      ),
    ),
  );
}

Widget _succesWidget(context, String email) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _logoApp(),
        _infosSucces(context, email),
        _closeButton(context),
      ],
    ),
  );
}

Widget _closeButton(context) {
  return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: () => Get.toNamed('/signin'),
      child: Text('Terminer',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)));
}

Widget _infosSucces(context, String email) {
  return Text("Un lien de reinitialisation est envoyée à l'adresse $email.",
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
      textAlign: TextAlign.center);
}

Widget _logoApp() {
  return Container(
    margin: EdgeInsets.only(top: 40),
    height: 100,
    width: 100,
    child: Image(
      image: AssetImage('assets/images/logo.png'),
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    ),
  );
}
