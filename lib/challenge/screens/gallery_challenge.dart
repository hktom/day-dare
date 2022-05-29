import 'package:application_challenge/bloc.dart';
import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:application_challenge/challenge/screens/views/no_challenge_found.dart';
// import 'package:application_challenge/contacts/screens/contact.dart';
import 'package:application_challenge/widgets/challenge_grid.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class GalleryChallenge extends StatelessWidget {
  const GalleryChallenge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map challenge = Get.arguments;

    challengeBloc(context)
        .add(OnLoadChildChallenge(challengeId: challenge['id']));

    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        child: BlocBuilder<ChallengeBloc, ChallengeState>(
          builder: (context, state) {
            if (state.children == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.children!.isEmpty) {
              return Center(
                child: _placeHolder(context),
              );
            }

            return challengeGrid(context: context, challenges: state.children);
          },
        ),
      ),
    );
  }
}

Widget _placeHolder(context) {
  return noChallengeFound(
    context,
    infos: "Aucune personne n'a encore participé à ce challenge",
    icon: Icons.follow_the_signs_outlined,
    iconColor: Colors.blueAccent,
  );
}

PreferredSize _appBar(context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(55.5),
    child: AppBar(
      backgroundColor: Theme.of(context).accentColor,
      elevation: 2,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: Text(
        'challenge gallery',
        style: Theme.of(context).textTheme.headline6,
      ),
    ),
  );
}
