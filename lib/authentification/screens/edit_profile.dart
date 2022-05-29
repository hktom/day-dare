import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/authentification/screens/sigin_with_google.dart';
import 'package:application_challenge/authentification/screens/view/form.dart';

import 'package:application_challenge/widgets/header/header_secondary.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  Map<String, TextEditingController> _controller = {
    'name': new TextEditingController(),
  };

  @override
  void initState() {
    authentificationBloc(context).add(ResetError());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _controller['name']!.text =
        authentificationBloc(context).state.userProfile!['displayName'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Nom'),
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
              Container(
                width: size.width * 0.85,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authentificationBloc(context).add(
                          UpdateUserProfile(
                            fields: {
                              'displayName': controller['name']!.text,
                            },
                          ),
                        );
                      }
                      Get.back();
                    },
                    child: Text(
                      "Mettre à jour",
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
