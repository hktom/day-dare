import 'package:application_challenge/widgets/header/header_secondary.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({Key? key}) : super(key: key);
  final List<String> items = [
    'one',
    'two',
    'three',
    'four',
    'one',
    'two',
    'three',
    'four'
  ];

  Widget articleItem(BuildContext context, {required int articleIndex}) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '$articleIndex.',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black.withOpacity(.8),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
              child: Text(
                'Lorem ipsum dolor sit amet consectetur adipising. Lorem ipsum dolor sit amet consectetur adipising.',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black.withOpacity(.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: headerSecondary(
          context,
          titleScreen: 'Conditions d\'utilisation',
          titleColor: Colors.white,
          iconColor: Colors.white,
          bkgColor: Theme.of(context).accentColor,
          elevation: 0,
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: Text(
                  'Les lignes suivantes reprennent les conditions d\'utilisation pour cette application.',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
              ),
              //list of articles
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  height: 645,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return articleItem(
                        context,
                        articleIndex: index + 1,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
