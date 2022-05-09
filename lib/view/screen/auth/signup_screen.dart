import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late Future<UserRegister> futureUserRegister;
  late Future<UserProfile> futureUserProfile;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final emailController = TextEditingController();
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
              // textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('ساخت حساب کاربری',
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
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                              fontFamily: 'iransans', color: Colors.white),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              hintText: 'نام کاربری',
                              hintStyle: TextStyle(fontFamily: 'iransans')),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorR.field,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                              fontFamily: 'iransans', color: Colors.white),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              hintText: 'ایمیل',
                              hintStyle: TextStyle(fontFamily: 'iransans')),
                        ),
                      ),
                      SizedBox(
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
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          style: TextStyle(
                              fontFamily: 'iransans', color: Colors.white),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              hintText: 'رمز عبور',
                              hintStyle: TextStyle(fontFamily: 'iransans')),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorR.field,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: password2Controller,
                          obscureText: true,
                          style: TextStyle(
                              fontFamily: 'iransans', color: Colors.white),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              hintText: 'تکرار رمز عبور',
                              hintStyle: TextStyle(fontFamily: 'iransans')),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        futureUserRegister = Services.createUserRegister(
                            usernameController.text,
                            passwordController.text,
                            emailController.text);
                        futureUserRegister.then((value) {
                          if (value.token != '0') {
                            futureUserProfile = Services.getUserProfile(
                                usernameController.text);
                            futureUserProfile.then((value) {
                              if (value.username != null) {
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
                                    content: Text(value.message),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('باشه'),
                                      )
                                    ],
                                  );
                                });
                          }
                        });
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
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        child: Text(
                          'از قبل حساب کاربری دارید؟',
                          style: TextStyle(fontFamily: 'iransans'),
                        )),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
