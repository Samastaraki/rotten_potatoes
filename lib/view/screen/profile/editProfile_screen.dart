// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotten_potatoes/utill/colorR.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Future login
  late Future<UpdateUser> futureUserUpdate;
  late Future<UserProfile> _userProfile;
  UploadImage uploadImage = UploadImage(data: null, statusCode: 400);
  // UserProfile _profile = ;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? imageFile;
  ImageProvider? imageProvider;
  bool isLoading = false;
  String dropdownValue = 'Person';

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    _userProfile = Services.getUserProfileP();
    _userProfile.then((value) {
      usernameController.text = value.username;
      emailController.text = value.email;
      fullnameController.text = value.fullname;
      dropdownValue = (value.sex == 'P')
          ? 'Person'
          : (value.sex == 'M')
              ? 'Male'
              : 'Female';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 60, bottom: 30),
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
                      height: 15,
                    ),
                    // edit email textfield
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
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
                      height: 15,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
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
                      height: 15,
                    ),
                    // fullname
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
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
                      height: 15,
                    ),
                    // dropdown
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: ColorR.text,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'iransans'),
                              underline: Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Person',
                                'Male',
                                'Female',
                              ]
                                  .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ))
                                  .toList(),
                            ),
                          )),
                    ),
                    // 20
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: RaisedButton(
                          onPressed: () async {
                            // loading
                            setState(() {
                              isLoading = true;
                            });
                            // choose image from gallery
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              imageFile = File(image!.path);
                              final bytes = await image!.readAsBytes();
                              imageProvider = MemoryImage(bytes);
                              // upload image to server
                              print('kalalakala');
                              uploadImage =
                                  await Services.uploadImage(imageFile!);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: Text(
                            'آپلود عکس',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'iransans',
                            ),
                          ),
                          color: ColorR.field,
                        ),
                      ),
                    ),
                    // 20
                    const SizedBox(
                      height: 15,
                    ),
                    // image box
                    (!isLoading)
                        ? Center(
                            child: Container(
                              height: 250,
                              width: 250,
                              child: imageProvider != null
                                  ? Image(
                                      image: imageProvider!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    // expanded
                    Expanded(child: Container()),
                    // save button
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: ColorR.text),
                        onPressed: () {
                          print(usernameController.text);
                          if (uploadImage.data != null) {
                            futureUserUpdate = Services.updateUser(
                                usernameController.text,
                                fullnameController.text,
                                emailController.text,
                                (dropdownValue == 'Person')
                                    ? 'P'
                                    : (dropdownValue == 'Male')
                                        ? 'M'
                                        : 'F',
                                'http://185.141.107.81:1111/static' +
                                    uploadImage.data['image_url']);
                            Services.updateUserProfileP(
                                usernameController.text,
                                fullnameController.text,
                                emailController.text,
                                (dropdownValue == 'Person')
                                    ? 'P'
                                    : (dropdownValue == 'Male')
                                        ? 'M'
                                        : 'F',
                                'http://185.141.107.81:1111/static' +
                                    uploadImage.data['image_url']);
                          } else {
                            futureUserUpdate = Services.updateUser(
                                usernameController.text,
                                fullnameController.text,
                                emailController.text,
                                (dropdownValue == 'Person')
                                    ? 'P'
                                    : (dropdownValue == 'Male')
                                        ? 'M'
                                        : 'F',
                                '');
                            Services.updateUserProfileP(
                                usernameController.text,
                                fullnameController.text,
                                emailController.text,
                                (dropdownValue == 'Person')
                                    ? 'P'
                                    : (dropdownValue == 'Male')
                                        ? 'M'
                                        : 'F',
                                '');
                          }
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
                  ]))),
    );
  }
}
