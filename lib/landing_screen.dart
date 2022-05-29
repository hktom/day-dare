import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          "assets/images/bkg_launch_screen.jpg",
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              alignment: Alignment.center,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      child: SvgPicture.asset(
                      "assets/images/landing.svg",
                      semanticsLabel: 'Challenge Logo',
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 110,
                    ),
                    ),

                    Flexible(
                      child: Container(
                        width: 210,
                        child: Text(
                          'Bienvenu sur Challenge',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ),
                    ),

                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                        width: 250,
                        child: Text(
                          'Crééz des challenges, des défis, et et invitez des contacts à relever ces défis. Go to challenge !',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ),
                    ),

                    Flexible(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        highlightColor: Colors.grey.withOpacity(.4),
                        splashColor: Colors.grey.withOpacity(.4),
                        radius: 3,
                        onTap: () => {Get.toNamed('/signin')},
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                            size: 30,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), 
              ]
            ),
          )
        ),
      ]
    );
  }
}