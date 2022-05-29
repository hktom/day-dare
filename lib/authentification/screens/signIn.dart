import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/authentification/screens/sigin_with_google.dart';
import 'package:application_challenge/authentification/screens/view/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, TextEditingController> _controller = {
    'email': new TextEditingController(),
    'password': new TextEditingController(),
  };

  @override
  void initState() {
    authentificationBloc(context).add(ResetError());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Connexion',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Connectez-vous pour s'authentifier",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.blueGrey.withOpacity(.9),
                              fontSize: 13,
                            ),
                      ),
                    ),
                    _formWidget(
                      _formKey,
                      context,
                      size: size,
                      controller: _controller,
                    ),
                    signInWithGoogle(
                      context,
                      titleButton: "Se connecter avec google",
                      size: size,
                    ),
                    _signUpButton(context, size),
                    _forgotPassword(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

void _signupListners(context, AuthentificationState state) {
  var bloc = authentificationBloc(context);
  if (state.status == 201) bloc.add(OnCreatedNewUser());
}

Widget _formWidget(_formKey, context,
    {Size? size, required Map<String, TextEditingController> controller}) {
  return BlocBuilder<AuthentificationBloc, AuthentificationState>(
    builder: (context, state) {
      _signupListners(context, state);
      return Container(
        width: size!.width * 0.85,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // echec authentication
              if (state.error != null && state.error != 'null')
                fieldError(context, state.error),

              // email textfield
              emailField(context, size, state,
                  controller: controller['email']!),

              // password textfield
              passwordField(context, size, state,
                  patternCheck: false, controller: controller['password']!),
              if (state.status == 100)
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.blue.shade400),
                ),
              // state.user["status"] == 100
              //         ? CircularProgressIndicator(color: Colors.white)
              Container(
                width: size.width * 0.85,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (state.status == 100) return null;

                          authentificationBloc(context).add(
                              SignInWithEmailAndPassword(userField: {
                            'email': controller['email']!.text,
                            'password': controller['password']!.text
                          }));
                        }
                      },
                      child: Text("Se connecter",
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.white,
                              ))),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _forgotPassword(context) {
  return TextButton(
      onPressed: () => Get.toNamed('/forgot_password'),
      child: Text('Mot de passe oublié ?',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.blue.withOpacity(.7), fontSize: 14),
          textAlign: TextAlign.center));
}

Widget _signUpButton(context, size) {
  return Container(
      width: size.width,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        runSpacing: 5.0,
        children: <Widget>[
          TextButton(
              onPressed: () {
                var bloc = authentificationBloc(context);
                if (bloc.state.status == 100) return null;
                Get.toNamed('/signup');
              },
              child: Text(
                "Pas de compte ? S'inscrire.",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black.withOpacity(.6),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ],
      ));
}
