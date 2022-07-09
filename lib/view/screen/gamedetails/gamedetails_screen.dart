import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/utill/images.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rotten_potatoes/view/screen/gamedetails/comments_screen.dart';
import 'package:marquee/marquee.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GameDetailsScreen> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetailsScreen> {
  late isSubscribe isSub;
  late Future<bool> _future;
  late String token;
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return FutureBuilder<String>(
        future: Services.getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            token = snapshot.data!;
            if (token != '0') {
              return FutureBuilder<isSubscribe>(
                  future: Services.isSubscribeGame(arguments['name']),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      isSub = snapshot.data!;
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Scaffold(
                            body: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 60),
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          width: 120,
                                          height: 185,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: (NetworkImage(
                                                    arguments['image'])),
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: 20),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                200,
                                        height: 185,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      200,
                                                  // width: 100,
                                                  child: Text(
                                                    arguments['name'],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                // genre
                                                Text(
                                                  'ژانر',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'iransans',
                                                  ),
                                                ),
                                                // SizedBox(height: 5),
                                                // year
                                                Text(
                                                  'سال ساخت',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'iransans',
                                                  ),
                                                ),
                                                // SizedBox(height: 5),
                                                // rating bar readonly

                                                RatingBar.builder(
                                                  ignoreGestures: true,
                                                  unratedColor: Colors.grey,
                                                  initialRating: double.parse(
                                                      arguments['rating']),
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
                                            // button follow
                                            Container(
                                              // width: double.infinity,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  _future =
                                                      Services.subscribeGame(
                                                          arguments['name']);
                                                  _future.then((value) {
                                                    setState(() {
                                                      // isSub = Services.isSubscribeGame(arguments['name']);
                                                    });
                                                  });
                                                  // setState(() {});
                                                },
                                                color:
                                                    (isSub.data['subscribed'] ==
                                                            false)
                                                        ? ColorR.text
                                                        : Colors.grey,
                                                child: Text(
                                                  (isSub.data['subscribed'] ==
                                                          false)
                                                      ? 'دنبال کردن'
                                                      : 'دنبال شده',
                                                  style: TextStyle(
                                                    // fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'iransans',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  // white line
                                  Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 10),
                                  // description
                                  Text(
                                    'توضیحات',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      // iransans
                                      fontFamily: 'iransans',
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(arguments['description'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        // color: Colors.black,
                                        // iransans
                                        fontFamily: 'iransans',
                                      )),

                                  // ListView.builder(
                                  //     physics: NeverScrollableScrollPhysics(),
                                  //     shrinkWrap: true,
                                  //     itemCount: 10,
                                  //     itemBuilder: (context, index) {
                                  //       return Container(
                                  //         height: 60,
                                  //         color: Colors.white,
                                  //         child: Text('نظر $index'),
                                  //       );
                                  //     }),

                                  SizedBox(height: 20),
                                  // white line
                                  Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 20),
                                  // button comment navigate to comment page
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    child: RaisedButton(
                                      onPressed: () {
                                        // String name = arguments['name'];
                                        Navigator.pushNamed(
                                          context,
                                          '/comment',
                                          arguments: {
                                            'name': arguments['name'],
                                            'rating': arguments['rating'],
                                          },
                                        );
                                      },
                                      color: ColorR.text,
                                      child: Text(
                                        'مشاهده نظرات',
                                        style: TextStyle(
                                          // fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'iransans',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // 20
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    child: RaisedButton(
                                      onPressed: () {
                                        // String name = arguments['name'];
                                        Navigator.pushNamed(
                                          context,
                                          '/game_posts',
                                          arguments: {
                                            'name': arguments['name'],
                                          },
                                        );
                                      },
                                      color: ColorR.text,
                                      child: Text(
                                        'پست های بازی',
                                        style: TextStyle(
                                          // fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'iransans',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // comments

                                  // ListView.builder(
                                  //     padding: EdgeInsets.only(top: 5),
                                  //     physics: NeverScrollableScrollPhysics(),
                                  //     shrinkWrap: true,
                                  //     itemCount: 3,
                                  //     itemBuilder: (context, index) {
                                  //       return Container(
                                  //           width: double.infinity,
                                  //           // height: 80,
                                  //           child: Column(
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Row(
                                  //                   children: [
                                  //                     Container(
                                  //                       width: 40,
                                  //                       height: 40,
                                  //                       child: Image.asset(Images.profile),
                                  //                     ),
                                  //                     SizedBox(width: 10),
                                  //                     Column(
                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                  //                       children: [
                                  //                         Text(
                                  //                           'محمد حسین زاده',
                                  //                           style: TextStyle(
                                  //                             fontSize: 15,
                                  //                             fontWeight: FontWeight.bold,
                                  //                             fontFamily: 'iransans',
                                  //                           ),
                                  //                         ),
                                  //                         SizedBox(height: 5),
                                  //                         Text(
                                  //                           'در تاریخ 1398/12/12',
                                  //                           style: TextStyle(
                                  //                             fontSize: 15,
                                  //                             fontWeight: FontWeight.normal,
                                  //                             fontFamily: 'iransans',
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //                 SizedBox(height: 10),
                                  //                 Text(
                                  //                   'این بازی برای مایکروسافت ویندوز، پلی استیشن 4 و ایکس باکس وان منتشر شد و اولین بازی از این سری است که دارای حالت کمپین چند نفره است.',
                                  //                   style: TextStyle(
                                  //                     fontSize: 15,
                                  //                     color: Colors.white,
                                  //                     // iransans
                                  //                     fontFamily: 'iransans',
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(height: 20),
                                  //               ]));
                                  //     }),
                                ]),
                          ),
                        )),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                    body: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 120,
                                  height: 185,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image:
                                            (NetworkImage(arguments['image'])),
                                        fit: BoxFit.cover),
                                  )),
                              SizedBox(width: 20),
                              Container(
                                width: MediaQuery.of(context).size.width - 200,
                                height: 185,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              200,
                                          // width: 100,
                                          child: Text(
                                            arguments['name'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        // genre
                                        Text(
                                          'ژانر',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'iransans',
                                          ),
                                        ),
                                        // SizedBox(height: 5),
                                        // year
                                        Text(
                                          'سال ساخت',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'iransans',
                                          ),
                                        ),
                                        // SizedBox(height: 5),
                                        // rating bar readonly

                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          unratedColor: Colors.grey,
                                          initialRating:
                                              double.parse(arguments['rating']),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 1.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ],
                                    ),
                                    // button follow
                                    Container(
                                      // width: double.infinity,
                                      child: RaisedButton(
                                        onPressed: () {},
                                        color: ColorR.text,
                                        child: Text(
                                          'دنبال کردن',
                                          style: TextStyle(
                                            // fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'iransans',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          // white line
                          Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          // description
                          Text(
                            'توضیحات',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // iransans
                              fontFamily: 'iransans',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(arguments['description'],
                              style: TextStyle(
                                fontSize: 15,
                                // color: Colors.black,
                                // iransans
                                fontFamily: 'iransans',
                              )),

                          SizedBox(height: 20),
                          // white line
                          Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 20),
                          // button comment navigate to comment page
                          Container(
                            width: double.infinity,
                            height: 45,
                            child: RaisedButton(
                              onPressed: () {
                                // String name = arguments['name'];
                                Navigator.pushNamed(
                                  context,
                                  '/comment',
                                  arguments: {
                                    'name': arguments['name'],
                                    'rating': arguments['rating'],
                                  },
                                );
                              },
                              color: ColorR.text,
                              child: Text(
                                'مشاهده نظرات',
                                style: TextStyle(
                                  // fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'iransans',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // 20
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 45,
                            child: RaisedButton(
                              onPressed: () {
                                // String name = arguments['name'];
                                Navigator.pushNamed(
                                  context,
                                  '/game_posts',
                                  arguments: {
                                    'name': arguments['name'],
                                  },
                                );
                              },
                              color: ColorR.text,
                              child: Text(
                                'پست های بازی',
                                style: TextStyle(
                                  // fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'iransans',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                )),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
