import 'package:flutter/material.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/utill/images.dart';
import 'package:rotten_potatoes/view/screen/auth/signup_screen.dart';
import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        // child:
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              Images.auth3,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            Text(
              'Rotten Potatoes',
              style: TextStyle(
                  // fontStyle: FontStyl,
                  fontWeight: FontWeight.w900,
                  // color: ColorR.text,
                  fontSize: 40,
                  fontFamily: 'iransans'),
            ),
            Text(
              'اینجا یک جهان از جهان های مختلف شماست',
              style: TextStyle(fontFamily: 'iransans', fontSize: 15),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ));
                  },
                  child: Text(
                    'ثبت نام',
                    style: TextStyle(fontFamily: 'iransans'),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.6, 50),
                    primary: ColorR.text,
                    onPrimary: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text(
                    'ورود',
                    style: TextStyle(fontFamily: 'iransans'),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.6, 50),
                    primary: Colors.white,
                    onPrimary: ColorR.text,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
