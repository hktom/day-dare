import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/authentification/screens/edit_profile.dart';
import 'package:application_challenge/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Container(
        child: BlocBuilder<AuthentificationBloc, AuthentificationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    title: Text('Modifier Nom'),
                    shape: Border(
                        bottom: BorderSide(width: 0.1, color: Colors.grey)),
                    subtitle: Text(state.userProfile!['displayName'] ?? ''),
                    trailing: IconButton(
                      onPressed: () {
                        Get.to(EditProfile());
                      },
                      icon: Icon(Icons.chevron_right),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    shape: Border(
                        bottom: BorderSide(width: 0.1, color: Colors.grey)),
                    title: Text('Email'),
                    subtitle: Text(state.userProfile!['id']),
                  ),
                  ListTile(
                    dense: true,
                    onTap: () {
                      authentificationBloc(context).add(LogOut());
                    },
                    title: Text(
                      'Se deconnecter',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
