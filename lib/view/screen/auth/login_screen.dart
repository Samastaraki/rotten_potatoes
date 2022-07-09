import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/view/screen/auth/signup_screen.dart';
import 'package:rotten_potatoes/view/screen/profile/profile_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Future login
  late Future<UserLogin> futureUserLogin;
  // future profile
  late Future<UserProfile> futureUserProfile;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // controllers
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 30),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('ورود به حساب',
                    style: TextStyle(fontSize: 30, fontFamily: 'iransans')),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorR.field,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: usernameController,
                          // onChanged: (value) {
                          //   usernameController.text = value;
                          // },
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                              fontFamily: 'iransans', color: Colors.white),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              hintText: 'نام کاربری',
                              hintStyle: TextStyle(
                                  fontFamily: 'iransans', color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorR.field,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: passwordController,
                          // onChanged: (value) {
                          //   passwordController.text = value;
                          // },
                          style: TextStyle(
                              fontFamily: 'iransans', color: Colors.white),
                          obscureText: true,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              hintText: 'رمز عبور',
                              hintStyle: TextStyle(
                                  fontFamily: 'iransans', color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        futureUserLogin = Services.createUserLogin(
                            usernameController.text, passwordController.text);
                        futureUserLogin.then((userLogin) {
                          if (userLogin.data != '0') {
                            futureUserProfile = Services.getUserProfile(
                                usernameController.text);
                            futureUserProfile.then((value) {
                              if (value.username != null) {
                                Services.setToken(userLogin.data);
                                Services.setUserProfileP(value);
                                Navigator.pushReplacementNamed(context, '/home',
                                    arguments: {
                                      'id': value.id,
                                      'username': value.username,
                                      'email': value.email,
                                      'fullname': value.fullname,
                                      'sex': value.sex
                                    });
                              }
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('خطا'),
                                    content: Text('اطلاعات اشتباه می باشد'),
                                    actions: [
                                      FlatButton(
                                        child: Text('باشه'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        });
                      },
                      child: Text(
                        'ورود',
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
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ));
                        },
                        child: Text(
                          'کاربر جدید هستید؟ اینجا را کلیک کنید.',
                          style: TextStyle(fontFamily: 'iransans'),
                        )),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
