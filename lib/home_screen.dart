import 'package:flutter/material.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/view/screen/landing/landing_screen.dart';
import 'package:rotten_potatoes/view/screen/profile/profile_screen.dart';
import 'package:rotten_potatoes/view/screen/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  // pages
  final _pageOptions = [
    ProfileScreen(),
    SearchScreen(),
    LandingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      backgroundColor: ColorR.background,
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'best'),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: ColorR.background,
        selectedItemColor: ColorR.text,
        unselectedItemColor: ColorR.text.withOpacity(0.5),
      ),
    );
  }
}
