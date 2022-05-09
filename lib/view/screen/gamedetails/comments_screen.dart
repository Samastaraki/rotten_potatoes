import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/utill/images.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late Future<List<ReviewGame>> _futureReviews;
  late Future<Review> _futureReview;
  final _commentController = TextEditingController();
  List<ReviewGame> _reviews = [];
  @override
  Widget build(BuildContext context) {
    double rate = 0;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    _futureReviews = Services.getReviewGame(arguments['name']);
    return FutureBuilder<List<ReviewGame>>(
      future: _futureReviews,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _reviews = snapshot.data!;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                floatingActionButton: FloatingActionButton(onPressed: () {
                  // show dialog for review game
                  showDialog(
                    context: context,
                    builder: (context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlertDialog(
                        backgroundColor: Colors.white,
                        alignment: Alignment.center,
                        // title: Text('نظر دادن به یک بازی'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text('نام بازی'),
                            Text(arguments['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'IRANSans',
                                    fontWeight: FontWeight.bold)),
                            Text('نظر شما'),
                            TextFormField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Text('امتیاز شما'),
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                rate = rating;
                                print(rate);
                              },
                            ),
                            RaisedButton(
                              onPressed: () {
                                // send review
                                _futureReview = Services.sendReviewGame(
                                    arguments['name'],
                                    // 'dota',
                                    _commentController.text,
                                    rate,
                                    'admin20');

                                _futureReview.then((value) {
                                  if (value.statusCode == 201) {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    print('error');
                                  }
                                });
                              },
                              child: Text('ثبت'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                body: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                  child: Column(children: [
                    Text(
                      'نظرات',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // iransans
                        fontFamily: 'iransans',
                      ),
                    ),
                    // white line
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 1,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _reviews.length,
                          itemBuilder: (context, index) {
                            // return _buildReview(context, _reviews[index]);
                            return Container(
                                width: double.infinity,
                                // height: 80,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            child: Image.asset(Images.profile),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _reviews[index].username,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'iransans',
                                                ),
                                              ),
                                              Text(
                                                'در تاریخ 1398/12/12',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'iransans',
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              // rate
                                              RatingBar.builder(
                                                ignoreGestures: true,
                                                unratedColor: Colors.grey,
                                                initialRating: double.parse(
                                                    _reviews[index].rating),
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
                                      SizedBox(height: 10),
                                      Text(
                                        _reviews[index].description,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          // iransans
                                          fontFamily: 'iransans',
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ]));
                          }),
                    ),
                  ]),
                )
                // ),
                // ],
                // ),
                ),
          );
          // },
          // ),
          // ],
          // ),
          // );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    // return Directionality(
    //   textDirection: TextDirection.rtl,
    //   child: Scaffold(
    //     body: Container(
    //       padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
    //       child: Column(
    //         children: [
    //           Text(
    //             'نظرات',
    //             style: TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //               // iransans
    //               fontFamily: 'iransans',
    //             ),
    //           ),
    //           // white line
    //           Container(
    //             margin: const EdgeInsets.only(top: 20),
    //             height: 1,
    //             color: Colors.white,
    //           ),
    //           SizedBox(height: 5),
    //           Expanded(
    //             child: ListView.builder(
    //                 padding: EdgeInsets.only(top: 5),
    //                 // physics: NeverScrollableScrollPhysics(),
    //                 // shrinkWrap: true,
    //                 itemCount: 6,
    //                 itemBuilder: (context, index) {
    //                   return Container(
    //                       width: double.infinity,
    //                       // height: 80,
    //                       child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Container(
    //                                   width: 60,
    //                                   height: 60,
    //                                   child: Image.asset(Images.profile),
    //                                 ),
    //                                 SizedBox(width: 10),
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                       'محمد حسین زاده',
    //                                       style: TextStyle(
    //                                         fontSize: 15,
    //                                         fontWeight: FontWeight.bold,
    //                                         fontFamily: 'iransans',
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       'در تاریخ 1398/12/12',
    //                                       style: TextStyle(
    //                                         fontSize: 15,
    //                                         fontWeight: FontWeight.normal,
    //                                         fontFamily: 'iransans',
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     // rate
    //                                     RatingBar.builder(
    //                                       unratedColor: Colors.grey,
    //                                       initialRating: 3.5,
    //                                       minRating: 1,
    //                                       direction: Axis.horizontal,
    //                                       allowHalfRating: true,
    //                                       itemCount: 5,
    //                                       itemSize: 20,
    //                                       itemPadding: EdgeInsets.symmetric(
    //                                           horizontal: 1.0),
    //                                       itemBuilder: (context, _) => Icon(
    //                                         Icons.star,
    //                                         color: Colors.amber,
    //                                       ),
    //                                       onRatingUpdate: (rating) {
    //                                         print(rating);
    //                                       },
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(height: 10),
    //                             Text(
    //                               'این بازی برای مایکروسافت ویندوز، پلی استیشن 4 و ایکس باکس وان منتشر شد و اولین بازی از این سری است که دارای حالت کمپین چند نفره است.',
    //                               style: TextStyle(
    //                                 fontSize: 15,
    //                                 color: Colors.white,
    //                                 // iransans
    //                                 fontFamily: 'iransans',
    //                               ),
    //                             ),
    //                             SizedBox(height: 20),
    //                           ]));
    //                 }),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
