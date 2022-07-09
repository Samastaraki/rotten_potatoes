import 'package:flutter/material.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/view/screen/auth/login_screen.dart';
import 'package:rotten_potatoes/view/screen/auth/signup_screen.dart';

class NoLoginScreen extends StatefulWidget {
  const NoLoginScreen({Key? key}) : super(key: key);

  @override
  State<NoLoginScreen> createState() => _NoLoginScreenState();
}

class _NoLoginScreenState extends State<NoLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 250),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                'جهت مشاهده پروفایل لطفا داخل اپلیکیشن ثبت نام کرده و یا وارد شوید',
                style: TextStyle(
                  fontFamily: 'iransans',
                  fontSize: 15,
                  color: ColorR.text,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),
            // 20
            SizedBox(height: 20),
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
                minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
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
                minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                primary: Colors.white,
                onPrimary: ColorR.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
