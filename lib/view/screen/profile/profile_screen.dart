import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/images.dart';

import 'editProfile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserProfile> _userProfile;
  // user review
  late Future<List<ReviewUser>> _userReviews;
  List<ReviewUser> _userReviewsList = [];
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    _userReviews = Services.getUserReview('admin20');
    return FutureBuilder<List<ReviewUser>>(
      future: _userReviews,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _userReviewsList = snapshot.data!;
          return FutureBuilder<UserProfile>(
            future: Services.getUserProfile('admin20'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserProfile _profile = snapshot.data!;
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    body: Column(children: <Widget>[
                      Padding(
                        // left 20, right 20, top 20, bottom 0
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(Images.profile),
                            ),
                            //white edit profile button

                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              // width: 120,
                              height: 50,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen()));
                                },
                                child: Text('ویرایش پروفایل',
                                    style: TextStyle(
                                        fontFamily: 'iransans',
                                        color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // username align right
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(_profile.username,
                                style: TextStyle(
                                    fontFamily: 'iransans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      // name align right
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(_profile.fullname,
                                style: TextStyle(
                                    fontFamily: 'iransans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      // followers and following with number of followers and following
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Row(
                            //   children: [
                            //     Text('دنبال کنندگان: ',
                            //         style: TextStyle(
                            //           fontFamily: 'iransans',
                            //           fontSize: 16,
                            //         )),
                            //     Text('۱۲۳۴',
                            //         style: TextStyle(
                            //           fontFamily: 'iransans',
                            //           fontSize: 16,
                            //         )),
                            //   ],
                            // ),
                            // width 50
                            SizedBox(
                              width: 30,
                            ),
                            // Row(
                            //   children: [
                            //     Text('دنبال شده ها: ',
                            //         style: TextStyle(
                            //           fontFamily: 'iransans',
                            //           fontSize: 16,
                            //         )),
                            //     Text('۱۲۳۴',
                            //         style: TextStyle(
                            //           fontFamily: 'iransans',
                            //           fontSize: 16,
                            //         )),
                            //   ],
                            // ),
                            // SizedBox(
                            //   width: 30,
                            // ),
                            // Row(
                            //   children: [
                            //     Text('پست ها: ',
                            //         style: TextStyle(
                            //           fontFamily: 'iransans',
                            //           fontSize: 16,
                            //         )),
                            //     Text('۱۲۳۴',
                            //         style: TextStyle(
                            //           fontFamily: 'iransans',
                            //           fontSize: 16,
                            //         )),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      // white line
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Container(
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _userReviewsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            AssetImage(Images.profile),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          // username
                                          Text(arguments['username'],
                                              style: TextStyle(
                                                  fontFamily: 'iransans',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)),
                                          // game
                                          Text(_userReviewsList[index].game,
                                              style: TextStyle(
                                                  fontFamily: 'iransans',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 45),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Text(
                                            _userReviewsList[index].description,
                                            style: TextStyle(
                                              fontFamily: 'iransans',
                                              fontSize: 13,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Padding(
                                        // right 100, left 100, top 20
                                        padding: const EdgeInsets.only(
                                            left: 100, right: 100, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.comment,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // grey line
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 20),
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
