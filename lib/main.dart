import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rotten_potatoes/home2_screen.dart';
import 'package:rotten_potatoes/home_screen.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/view/screen/auth/auth_screen.dart';
import 'package:rotten_potatoes/view/screen/gamedetails/comments_screen.dart';
import 'package:rotten_potatoes/view/screen/gamedetails/gamedetails_screen.dart';
import 'package:rotten_potatoes/view/screen/landing/landing_screen.dart';
import 'package:rotten_potatoes/view/screen/profile/profile_screen.dart';
import 'package:rotten_potatoes/view/screen/profile/userProfile_screen.dart';
import 'services.dart';
import 'view/screen/gamedetails/gameposts_screen.dart';
import 'view/screen/post/postGame_screen.dart';
import 'view/screen/search/search_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String temp = await Services.getToken();
  runApp(MyApp(
    token: temp,
  ));
}

class MyApp extends StatefulWidget {
  String token;
  MyApp({Key? key, required this.token}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String token;

  void initState() {
    super.initState();
    token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData light = ThemeData(
      scaffoldBackgroundColor: ColorR.background,
      primaryColor: ColorR.text,
      // textTheme: Theme.of(context).textTheme.apply(bodyColor: ColorR.text),
    );
    ThemeData dark = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.white,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: ColorR.text),
    );
    return GetMaterialApp(
      title: 'Gamers Gram',
      initialRoute: token == '0' ? '/' : '/home',
      routes: {
        '/': (context) => AuthScreen(),
        '/profile': (context) => ProfileScreen(),
        '/home': (context) => HomeScreen(),
        '/home2': (context) => Home2Screen(),
        '/search': (context) => SearchScreen(),
        '/game_details': (context) => GameDetailsScreen(),
        '/comment': (context) => CommentsScreen(),
        '/post_game': (context) => PostGameScreen(),
        '/landing': (context) => LandingScreen(),
        '/game_posts': (context) => GamePostsScreen(),
        '/user_details': (context) => UserScreen(),
      },
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.light,

      // home: token == '0'
      //     ? Directionality(
      //         textDirection: TextDirection.rtl, child: AuthScreen())
      //     : Directionality(
      //         textDirection: TextDirection.rtl, child: GameDetailsScreen()),
    );
  }
}
