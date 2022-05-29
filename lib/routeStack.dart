import 'package:application_challenge/challenge/screens/create_challenge.dart';
import 'package:application_challenge/challenge/screens/photo_video_picker.dart';
import 'package:application_challenge/challenge/screens/fil_challenge.dart';
import 'package:application_challenge/challenge/screens/mes_challenges.dart';
import 'package:application_challenge/contacts/screens/contact.dart';
import 'package:application_challenge/authentification/screens/profil.dart';
import 'package:application_challenge/people/screen/peoples.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RouteStack extends StatefulWidget {
  @override
  _RouteStackState createState() => _RouteStackState();
}

class _RouteStackState extends State<RouteStack> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _screens = [
    FilChallenge(),
    MesChallenges(),
    PhotoVideoPicker(isNew:true),
    PeoplesList(),
    Profil(),
    // Contacts(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              // Color.fromRGBO(7, 91, 154, .9),
              Color(0xFFB17419),
              Colors.orange,
              Colors.orange,
            ],
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          // fixedColor: Color(0xFF0C003F),
          fixedColor: Colors.blue,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          iconSize: 25,
          selectedIconTheme: IconThemeData(
            color: Colors.blue,
          ),
          unselectedFontSize: 11,
          selectedFontSize: 11,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.flagCheckered),
              label: 'Challenges',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.plusCircle,
                color: Colors.blue,
                size: 40,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.users),
              label: 'Challengers',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userCircle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
