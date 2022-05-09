import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Future login
  late Future<UpdateUser> futureUserUpdate;
  late Future<UserProfile> _userProfile;
  // UserProfile _profile = ;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // controllers

    _userProfile = Services.getUserProfile('admin20');

    return FutureBuilder<UserProfile>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfile _profile = snapshot.data!;
            usernameController.text = _profile.username;
            fullnameController.text = _profile.fullname;
            emailController.text = _profile.email;
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  body: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 80),
                      child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ویرایش پروفایل
                                Center(
                                  child: Text('ویرایش پروفایل',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'iransans',
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // edit email textfield
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: TextFormField(
                                        controller: emailController,
                                        // initialValue: 'admin15@gmail.com',
                                        decoration: new InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: 'ایمیل',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'iransans',
                                          ),
                                          // border: OutlineInputBorder(
                                          //     borderRadius:
                                          //         BorderRadius.all(Radius.circular(20)),
                                          //     borderSide: BorderSide(
                                          //         color: Colors.red, width: 10))),
                                        ),
                                      ),
                                    )),
                                // 20
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: TextFormField(
                                        controller: usernameController,
                                        // initialValue: 'admin15',
                                        decoration: new InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: 'نام کاربری',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'iransans',
                                          ),
                                          // border: OutlineInputBorder(
                                          //     borderRadius:
                                          //         BorderRadius.all(Radius.circular(20)),
                                          //     borderSide: BorderSide(
                                          //         color: Colors.red, width: 10))),
                                        ),
                                      ),
                                    )),
                                // 20
                                const SizedBox(
                                  height: 20,
                                ),
                                // fullname
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: TextFormField(
                                        controller: fullnameController,
                                        // initialValue: 'حسن خسروی',
                                        decoration: new InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: 'نام و نام خانوادگی',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'iransans',
                                          ),
                                          // border: OutlineInputBorder(
                                          //     borderRadius:
                                          //         BorderRadius.all(Radius.circular(20)),
                                          //     borderSide: BorderSide(
                                          //         color: Colors.red, width: 10))),
                                        ),
                                      ),
                                    )),
                                // 20
                                const SizedBox(
                                  height: 20,
                                ),
                                // save button
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.blue),
                                  child: FlatButton(
                                    onPressed: () {
                                      print(usernameController.text);
                                      futureUserUpdate = Services.updateUser(
                                          usernameController.text,
                                          fullnameController.text,
                                          emailController.text);
                                      futureUserUpdate.then((value) {
                                        if (value.statusCode == 200) {
                                          Navigator.pop(context);
                                        } else {}
                                      });
                                    },
                                    child: Text(
                                      'ذخیره',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'iransans'),
                                    ),
                                  ),
                                ),
                              ])))),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
