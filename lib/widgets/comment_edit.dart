import 'package:application_challenge/challenge/bloc/challenge_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../bloc.dart';

class CommentEditor extends StatelessWidget {
  // const CommentEditor({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.black54,
              width: .8,
            ),
          )),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        leading: CachedNetworkImage(
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          imageUrl:
              authentificationBloc(context).state.userProfile!['photoURL'],
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
            backgroundColor: Colors.white,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            if (controller.text.length > 0) {
              challengeBloc(context).add(OnPostCommentChallenge(
                user: authentificationBloc(context).state.userProfile!,
                content: controller.text,
                docId: challengeBloc(context).state.payload!['id'],
              ));
              controller.clear();
            }
          },
          icon: Icon(
            Icons.send,
            color: Colors.blue[900],
          ),
        ),
        title: TextFormField(
          autofocus: false,
          cursorHeight: 16.0,
          minLines: 2,
          maxLines: 10,
          controller: controller,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            focusColor: Colors.blueAccent,
            hintText: "Commentaire...",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.grey,
                ),
            hintMaxLines: 2,
          ),
        ),
      ),
    );
  }
}
