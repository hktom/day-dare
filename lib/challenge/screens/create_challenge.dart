import 'dart:io';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/challenge/screens/player/simple_player.dart';
import 'package:application_challenge/people/screen/invite_people.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// import 'package:application_challenge/challenge/screens/player/multi_manager.dart';
// import 'package:application_challenge/challenge/screens/player/portrait_player.dart';
// import 'package:application_challenge/challenge/screens/video_app.dart';
// import 'package:application_challenge/widgets/header/header_secondary.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';

import '../../bloc.dart';

class CreateChallenge extends StatefulWidget {
  final bool? isNew;
  final bool? isVideo;
  const CreateChallenge({Key? key, this.isNew, this.isVideo}) : super(key: key);

  @override
  _CreateChallengeState createState() => _CreateChallengeState();
}

class _CreateChallengeState extends State<CreateChallenge> {
  Map controller = {
    'description': new TextEditingController(),
    'isPrivate': false,
    'duration': '2 heures',
  };

  setDuration(value) {
    setState(() {
      controller['duration'] = value;
    });
  }

  setPrivacy(value) {
    setState(() {
      controller['isPrivate'] = value;
    });
  }

  void publishChallenge(payload) {
    challengeBloc(context).add(OnCreatingChallenge(
        user: authentificationBloc(context).state.user!,
        profile: authentificationBloc(context).state.userProfile!,
        formChallenge:
            widget.isNew! ? null : challengeBloc(context).state.payload,
        payload: payload));
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        title: Text("Publier"),
        actions: [
          IconButton(
              onPressed: () {
                Map payload = {
                  "description": controller['description'].text,
                  "isPrivate": controller['isPrivate'],
                  "duration": controller["duration"],
                };
                if (controller['isPrivate']) {
                  Get.to(PeopleInvitation(payload: payload));
                } else {
                  publishChallenge(payload);
                }
              },
              icon: Icon(Icons.send))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 100,
        child: _formChallenge(
          isVideo: widget.isVideo,
          context: context,
          controller: controller,
          setDuration: setDuration,
          setPrivacy: setPrivacy,
          isNew: widget.isNew,
        ),
      ),
    );
  }
}

Widget _formChallenge({
  bool? isNew,
  bool? isVideo,
  required context,
  required controller,
  required Function setDuration,
  required Function setPrivacy,
}) {
  return BlocBuilder<ChallengeBloc, ChallengeState>(
    builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // photo et titre
            isVideo != null
                ? _simpleplayer(state.payloadVideoTrimmed)
                : _image(context),
            _description(context, controller['description']),
            Divider(color: Colors.grey.shade300),
            if (isNew!) ...[
              Divider(color: Colors.grey.shade300),
              _privacy(context, controller['isPrivate'], setPrivacy),
              Divider(color: Colors.grey.shade300),
              _duration(controller['duration'], setDuration),
            ],
          ],
        ),
      );
    },
  );
}

Widget _simpleplayer(File? file) {
  if (file == null) {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey.shade100,
    );
  }

  return SimplePlayer(video: file);
}

Widget _image(context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 100,
    height: 300,
    child: FutureBuilder<File?>(
      future: challengeBloc(context).state.payloadImage,
      builder: (_, snapshot) {
        if (snapshot.data == null) return Container();
        return Image.file(snapshot.data!, fit: BoxFit.cover);
      },
    ),
  );
}

Widget _description(context, controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: TextField(
      maxLines: 10,
      minLines: 2,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Ajouter une description pour ce challenge',
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black.withOpacity(.6),
              fontSize: 12,
            ),
        border: InputBorder.none,
        focusColor: Colors.blue,
      ),
      autofocus: false,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
    ),
  );
}

Widget _privacy(context, controller, Function update) {
  return SwitchListTile(
    dense: true,
    isThreeLine: false,
    title: Text("Challenge statut"),
    subtitle: Text(
      controller ? 'Privé' : 'Public',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.blue,
          ),
    ),
    value: controller,
    activeColor: Colors.blue,
    onChanged: (bool value) {
      update(value);
    },
    // secondary: const Icon(Icons.lightbulb_outline),
  );
}

Widget _duration(controller, Function setDuration) {
  return Flex(
    direction: Axis.horizontal,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Durée: '),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<String>(
            value: controller,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 1,
            style: const TextStyle(color: Colors.deepPurple),
            underline: SizedBox(),
            onChanged: (String? value) {
              setDuration(value);
            },
            items: <String>['2 heures', '4 heures', '12 heures', '24 heures']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    ],
  );
}
