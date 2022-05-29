import 'package:application_challenge/authentification/bloc/authentification_bloc.dart';
import 'package:application_challenge/challenge/screens/photo_video_picker.dart';
import 'package:application_challenge/people/bloc/people_bloc.dart';
import 'package:application_challenge/widgets/challenge_grid.dart';
import 'package:application_challenge/widgets/header/header_without_return_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc.dart';

class PeopleProfile extends StatefulWidget {
  final Map user;

  const PeopleProfile({Key? key, required this.user}) : super(key: key);

  @override
  _PeopleProfileState createState() => _PeopleProfileState();
}

class _PeopleProfileState extends State<PeopleProfile> {
  // final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isFollow = false;

  void toggleFollow(value) {
    setState(() {
      isFollow = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var params = widget.user;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text("${params['displayName'] ?? 'No pseudo'}"),
        elevation: 0,
        actions: [
          if (params['id'] == authentificationBloc(context).state.user!.email)
            IconButton(
              onPressed: () {
                Get.toNamed('/setting');
              },
              icon: Icon(Icons.menu),
            )
        ],
      ),
      // extendBodyBehindAppBar: true,
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // image profil
                  Align(
                    alignment: Alignment.center,
                    child: _imageProfile(context, state: params),
                  ),
                  params['displayName'] != null
                      ? Text('@' + params['displayName'])
                      : Text('No Pseudo'),

                  if (params['id'] !=
                      authentificationBloc(context).state.user!.email)
                    _buttonFollowUnFollow(
                            context, state, isFollow, toggleFollow) ??
                        SizedBox(),

                  SizedBox(height: 20),
                  _profileStatistique(context),
                  Divider(),
                  SizedBox(height: 20),
                  if (peopleBloc(context).state.challenges != null)
                    SizedBox(
                      child: challengeGrid(
                        context: context,
                        challenges: peopleBloc(context).state.challenges,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget? _buttonFollowUnFollow(
    context, PeopleState state, bool isFollow, Function toggleFollow) {
  if (state.followers == null || state.followers!.isEmpty) {
    return _followButton(context, false);
  }

  bool theUserIsFollowers = false;

  state.followers!.forEach((element) {
    theUserIsFollowers =
        authentificationBloc(context).state.user!.email == element['id']
            ? true
            : false;
  });

  return _followButton(context, theUserIsFollowers);
}

Widget _followButton(context, bool isFollow) {
  bool followIndicator = peopleBloc(context).state.toogleFollow ?? isFollow;

  return Container(
    margin: EdgeInsets.only(top: 15),
    decoration: BoxDecoration(
      color: followIndicator ? Colors.white : Colors.blue,
      border: Border.all(color: Colors.blue, width: 2),
    ),
    child: SizedBox(
      width: 100,
      child: TextButton(
          onPressed: () {
            peopleBloc(context).add(
              ToggleFollow(
                  user: authentificationBloc(context).state.userProfile!,
                  docId: peopleBloc(context).state.people!['id'],
                  doc: peopleBloc(context).state.people!,
                  toogle: !followIndicator),
            );
          },
          child: Text(
            followIndicator ? 'Unfollow' : 'Follow',
            style:
                TextStyle(color: followIndicator ? Colors.blue : Colors.white),
          )),
    ),
  );
}

Widget _profileStatistique(context) {
  return Container(
    width: MediaQuery.of(context).size.width * 10,
    child: Align(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: _itemColumn(
                'Challenges',
                peopleBloc(context).state.challenges != null
                    ? peopleBloc(context).state.challenges!.length
                    : 0),
          ),
          Expanded(
            flex: 1,
            child: _itemColumn(
                'Followers',
                peopleBloc(context).state.followers != null
                    ? peopleBloc(context).state.followers!.length
                    : 0),
          ),
          Expanded(
            flex: 1,
            child: _itemColumn(
                'Followings',
                peopleBloc(context).state.followings != null
                    ? peopleBloc(context).state.followings!.length
                    : 0),
          ),
        ],
      ),
    ),
  );
}

Widget _itemColumn(String label, int? value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [Text(label), Text(value.toString())],
  );
}

Widget _imageProfile(BuildContext context, {required Map state}) {
  return InkWell(
    onTap: () {
      if (state['id'] == authentificationBloc(context).state.user!.email) {
        authentificationBloc(context).add(OnEditingProfileImage());
        Get.to(PhotoVideoPicker(uploadChallenge: false, isNew: false));
      }
    },
    child: Container(
      margin: EdgeInsets.only(top: 30, bottom: 5),
      child: Container(
        child: CachedNetworkImage(
          height: 180,
          width: 180,
          fit: BoxFit.cover,
          imageUrl: state['photoURL'],
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    ),
  );
}
