import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/utill/images.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // late Future<UserProfile> _userProfile = Services.getUserProfileP();
  // user review
  late Future<List<ReviewUser>> _userReviews;
  List<ReviewUser> _userReviewsList = [];
  late Future<String> _token = Services.getToken();
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    // get token Future Build
    return FutureBuilder<UserProfile>(
      future: Services.getUserProfile(arguments['username']),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserProfile _profile = snapshot.data!;
          _userReviews = Services.getUserReview(_profile.username);
          return FutureBuilder<List<ReviewUser>>(
            future: _userReviews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _userReviewsList = snapshot.data!;
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
                            (_profile.image != null)
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(_profile.image))
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(Images.profile),
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
                          color: Colors.black,
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
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/comment',
                                            arguments: {
                                              'name':
                                                  _userReviewsList[index].game,
                                              'rating': _userReviewsList[index]
                                                  .rating,
                                            },
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // username
                                            Text(_profile.username,
                                                style: TextStyle(
                                                    fontFamily: 'iransans',
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            // game
                                            Row(
                                              // space between
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    _userReviewsList[index]
                                                        .game,
                                                    style: TextStyle(
                                                        fontFamily: 'iransans',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                // sizedbox 10
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                // rate
                                                RatingBar.builder(
                                                  ignoreGestures: true,
                                                  unratedColor: Colors.grey,
                                                  initialRating: double.parse(
                                                      _userReviewsList[index]
                                                          .rating
                                                          .toString()),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 20,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
                                              color: Colors.black,
                                            )),
                                      ),
                                      // Padding(
                                      //   // right 100, left 100, top 20
                                      //   padding: const EdgeInsets.only(
                                      //       left: 100, right: 100, top: 10),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Icon(
                                      //         Icons.favorite_border,
                                      //         color: ColorR.text,
                                      //       ),
                                      //       SizedBox(
                                      //         width: 10,
                                      //       ),
                                      //       Icon(
                                      //         Icons.comment,
                                      //         color: ColorR.text,
                                      //       ),
                                      //       SizedBox(
                                      //         width: 10,
                                      //       ),
                                      //       Icon(
                                      //         Icons.share,
                                      //         color: ColorR.text,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
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
