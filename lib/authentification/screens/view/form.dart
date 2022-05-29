import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget fieldError(context, error) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.red,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        error,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
        textAlign: TextAlign.left,
      ));
}

Widget passwordField(context, size, state,
    {bool patternCheck: false, required TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Remplissez le mot de passe';
        }

        if (patternCheck == true) {
          if (value.length < 6) {
            return 'Le mot de passe doit depasser 5 caractères';
          }

          if (value.contains(RegExp(r'[A-Z]'))) {
            return 'Le mot de passe doit contenir au moins une lettre';
          }
        }

        return null;
      },
      decoration: const InputDecoration(
        hintText: "Mot de passe",
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.black12,
          fontSize: 14,
        ),
      ),
      keyboardType: TextInputType.multiline,
      obscureText: true,
      controller: controller,
      // onChanged: (String value) {
      //   Map data = state.user["userField"] ?? {"password": value};
      //   data['password'] = value;
      //   authentificationBloc(context)
      //       .add(OnFieldChanged(userField: data));
      // },
    ),
  );
}

Widget emailField(context, size, state,
    {required TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Remplissez l\' email';
        }

        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return 'Votre email est invalide';
        }

        return null;
      },
      decoration: const InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.black12,
          fontSize: 14,
        ),
      ),
      keyboardType: TextInputType.multiline,
      controller: controller,
      // onChanged: (String value) {
      //   String _deleteSpace = value.replaceAll(" ", "");

      //   Map data = state.user["userField"] ?? {"email": _deleteSpace};
      //   data['email'] = _deleteSpace;
      //   // return print("lol $data");
      //   authentificationBloc(context)
      //       .add(OnFieldChanged(userField: data));
      // },
    ),
  );
}

Widget nameField(context, size, state,
    {required TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Remplissez un nom';
        }

        return null;
      },
      decoration: const InputDecoration(
        hintText: "Pseudo",
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.black12,
          fontSize: 14,
        ),
      ),
      keyboardType: TextInputType.multiline,
      controller: controller,
      // onChanged: (String value) {
      //   Map data = state.user["userField"] ?? {"displayName": value};
      //   data['displayName'] = value;
      //   authentificationBloc(context)
      //       .add(OnFieldChanged(userField: data));
      // },
    ),
  );
}

Widget confirmPasswordField(context, size, state,
    {required TextEditingController controller,
    required TextEditingController controller_2}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez confirmer votre mot de passe';
        }

        if (value != controller_2.text) {
          return 'Vos mots de passe ne sont pas le meme';
        }

        return null;
      },
      decoration: const InputDecoration(
        hintText: "Confirmez le mot de passe",
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.black12,
          fontSize: 14,
        ),
      ),
      keyboardType: TextInputType.multiline,
      obscureText: true,
      controller: controller,
      // onChanged: (String value) {
      //   Map data = state.user["userField"] ?? {"confirmPassword": value};
      //   data['confirmPassword'] = value;
      //   authentificationBloc(context)
      //       .add(OnFieldChanged(userField: data));
      // },
    ),
  );
}
