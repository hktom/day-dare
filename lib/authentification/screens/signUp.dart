import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/authentification/screens/sigin_with_google.dart';
import 'package:application_challenge/authentification/screens/view/form.dart';

import 'package:application_challenge/widgets/header/header_secondary.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: headerSecondary(
          context,
          titleScreen: 'Inscription',
          titleColor: Colors.black.withOpacity(.8),
          iconColor: Colors.black.withOpacity(.7),
          bkgColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // form
                    _formWidget(
                      _formKey,
                      context,
                      size: size,
                      controller: _controller,
                    ),

                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 15),
                    //   child: Center(
                    //     child: Text('Ou'),
                    //   ),
                    // ),

                    //Widget displays social network icon button for authentication
                    signInWithGoogle(
                      context,
                      titleButton: "S'inscrire avec google",
                      size: size,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void _signupListners(context, state) {
//   var bloc = authentificationBloc(context);
//   if (state.status == 201) bloc.add(OnCreatedNewUser());
// }

Widget _formWidget(
  _formKey,
  BuildContext context, {
  Size? size,
  Map<String, TextEditingController>? controller,
}) {
  return BlocBuilder<AuthentificationBloc, AuthentificationState>(
    builder: (context, state) {
      return Container(
        width: size!.width * 0.85,
        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (state.error != null && state.error != 'null')
                fieldError(context, state.error),

              nameField(context, size, state, controller: controller!['name']!),

              // email textfield
              emailField(context, size, state,
                  controller: controller['email']!),

              passwordField(context, size, state,
                  patternCheck: true, controller: controller['password']!),

              // confirm password textfield
              confirmPasswordField(context, size, state,
                  controller: controller['password_confirm']!,
                  controller_2: controller['password']!),

              if (state.status == 100)
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.blue.shade400),
                ),

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
                          SignUpWithEmailAndPassword(
                            userField: {
                              'name': controller['name']!.text,
                              'email': controller['email']!.text,
                              'password': controller['password']!.text,
                              'password_confirm':
                                  controller['password_confirm']!.text
                            },
                          ),
                        );
                      }
                    },
                    child: Text(
                      "S'inscire",
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
