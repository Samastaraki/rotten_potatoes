// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:image_picker/image_picker.dart';

class PostGameScreen extends StatefulWidget {
  const PostGameScreen({Key? key}) : super(key: key);

  @override
  State<PostGameScreen> createState() => _PostGameScreenState();
}

class _PostGameScreenState extends State<PostGameScreen> {
  late Future<GameAdd> futureGameAdd;
  // controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  //bools
  bool _ists = false;
  bool _isds = false;
  XFile? image;
  File? imageFile;
  ImageProvider? imageProvider;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 30),
          child: Column(children: [
            // title of page
            Text(
              'ثبت بازی',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            // 20
            SizedBox(height: 20),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: (_ists) ? Colors.blue : Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'عنوان بازی',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'iransans',
                      ),
                    ),
                  ),
                )),
            // 20
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 8 * 24,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 8,
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'توضیحات بازی',
                      hintStyle: TextStyle(
                        // height: 2,
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'iransans',
                      ),
                    ),
                  ),
                )),
            // 20
            const SizedBox(
              height: 20,
            ),
            // upload image button
            Container(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: RaisedButton(
                  onPressed: () async {
                    // choose image from gallery
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    imageFile = File(image!.path);
                    final bytes = await image!.readAsBytes();
                    imageProvider = MemoryImage(bytes);
                    setState(() {});
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
              height: 20,
            ),
            // image box
            Container(
              height: 240,
              child: imageProvider != null
                  ? Image(
                      image: imageProvider!,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
            // expanded
            Expanded(child: Container()),
            // submit button
            Container(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: RaisedButton(
                  onPressed: () {
                    if (_titleController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('عنوان بازی را وارد کنید'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('باشه'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else if (_descriptionController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('توضیحات بازی را وارد کنید'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('باشه'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    } else if (imageFile == null) {
                      futureGameAdd = Services.addGame1(
                          _titleController.text, _descriptionController.text);
                      futureGameAdd.then((value) {
                        if (value.statusCode == 201) {
                          print('success');
                          Navigator.pop(context);
                        } else {
                          print('error');
                        }
                      });
                    } else {
                      futureGameAdd = Services.addGame(_titleController.text,
                          _descriptionController.text, imageFile!);
                      futureGameAdd.then((value) {
                        if (value.statusCode == 201) {
                          print('success');
                          Navigator.pop(context);
                        } else {
                          print('error');
                        }
                      });
                    }
                    // submit
                    // futureGameAdd = Services.addGame(_titleController.text,
                    //     _descriptionController.text, imageFile!);
                    // futureGameAdd.then((value) {
                    //   if (value.statusCode == 201) {
                    //     print('success');
                    //     Navigator.pop(context);
                    //   } else {
                    //     print('error');
                    //   }
                    // });
                  },
                  child: Text(
                    'ثبت',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'iransans',
                    ),
                  ),
                  color: ColorR.text,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
