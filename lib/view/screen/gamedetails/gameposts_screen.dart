import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/utill/images.dart';

class GamePostsScreen extends StatefulWidget {
  const GamePostsScreen({Key? key}) : super(key: key);

  @override
  State<GamePostsScreen> createState() => _GamePostsScreenState();
}

class _GamePostsScreenState extends State<GamePostsScreen> {
  late Future<List<PostGame>> _futurePosts;
  late Future<PostGame> _futurePost;
  late Future<List<CommentGame>> _futureComments;
  late Future<CommentGame> _futureComment;
  late Future<CommentGame> _futureReply;
  // late Future< _futureComment;
  // late Future<PostGame> _futurePost;
  List<PostGame> _posts = [];
  List<CommentGame> _comments = [];
  List<CommentGame> _answers = [];
  final _postController = TextEditingController();
  // final _commentController = TextEditingController();
  final _replyController = TextEditingController();

  // initState() {
  //   super.initState();
  //   _futurePosts = Services.getPosts();
  //   _futureComments = Services.getComments();
  // }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    _futurePosts = Services.getPostGame(arguments['name']);
    return FutureBuilder<List<PostGame>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _comments.clear();
            _posts = snapshot.data!;
            // sort _posts by id
            _posts.sort((a, b) => b.data['id'].compareTo(a.data['id']));
            // boolean for each post
            // var _isPostonC =
            //     List<bool>.generate(_posts.length, (index) => false);
            // controller for each post
            var _commentController = List<TextEditingController>.generate(
                _posts.length, (index) => TextEditingController());
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: ColorR.text,
                      onPressed: () {
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
                                  Text('پست شما'),
                                  TextFormField(
                                    controller: _postController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      // send review
                                      _futurePost = Services.sendPostGame(
                                          arguments['name'],
                                          _postController.text);
                                      _futurePost.then((value) {
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
                    padding:
                        const EdgeInsets.only(top: 50, right: 20, left: 20),
                    child: Column(children: [
                      Text(
                        'پست های بازی',
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
                        color: Colors.black,
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _posts.length,
                            itemBuilder: (context, index) {
                              _futureComments = Services.getCommentGame(
                                  _posts[index].data['id']);
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
                                              child:
                                                  Image.asset(Images.profile),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // 'username',
                                                  _posts[index]
                                                      .data['username'],
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
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: 'iransans',
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                // 'لورم ایپسوم یا طرح‌نما (به انگلیسی: Lorem ipsum) به متنی آزمایشی و بی‌معنی در صنعت چاپ، صفحه‌آرایی و طراحی گرافیک گفته می‌شود. طراح گرافیک از این متن به عنوان عنصری از ترکیب بندی برای پر کردن صفحه و ارایه اولیه شکل ظاهری و کلی طرح سفارش گرفته شده استفاده می نماید.',
                                                _posts[index].data['content'],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  // color: Colors.black,
                                                  // iransans
                                                  fontFamily: 'iransans',
                                                ),
                                              ),
                                            ),
                                            // IconButton(
                                            //     onPressed: () {},
                                            //     icon:
                                            //         Icon(Icons.favorite_border))
                                          ],
                                        ),
                                        // SizedBox(height: 5),
                                        Container(
                                          // height: 50,
                                          // width: 250,
                                          padding: EdgeInsets.only(right: 40),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                // width: 200,
                                                child: TextFormField(
                                                  // text color black
                                                  style: TextStyle(
                                                      // color: Colors.black
                                                      ),
                                                  controller:
                                                      _commentController[index],
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'نظر خود را بنویسید',
                                                    // fillColor: Colors.black,
                                                    // border:
                                                    //     OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: ColorR.text,
                                                ),
                                                onPressed: () {
                                                  // send comment
                                                  _futureComment =
                                                      Services.sendCommentGame(
                                                          _posts[index]
                                                              .data['id'],
                                                          _commentController[
                                                                  index]
                                                              .text);
                                                  _futureComment.then((value) {
                                                    if (value.statusCode ==
                                                        201) {
                                                      setState(() {
                                                        _commentController[
                                                                index]
                                                            .clear();
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
                                        // (_isPostonC[index] == true)
                                        //     ? Container(
                                        //         color: Colors.black,
                                        //         height: 20,
                                        //       )
                                        //     : Container(),
                                        // 5
                                        SizedBox(height: 5),
                                        FutureBuilder<List<CommentGame>>(
                                            future: _futureComments,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                _comments = snapshot.data!;
                                                return Container(
                                                    // height:
                                                    //     _comments.length * 150,
                                                    child: ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            _comments.length,
                                                        itemBuilder:
                                                            (context, index2) {
                                                          print(index2);
                                                          return Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 40,
                                                                      top: 10),
                                                              width: double
                                                                  .infinity,
                                                              // height: 150,
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Image.asset(Images.profile),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 10),
                                                                          Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  // 'username',
                                                                                  _comments[index2].data['username'],
                                                                                  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontFamily: 'iransans',
                                                                                  ),
                                                                                ),
                                                                                Text('در تاریخ 1398/12/12',
                                                                                    style: TextStyle(
                                                                                      fontSize: 15,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontFamily: 'iransans',
                                                                                    ))
                                                                              ])
                                                                        ]),
                                                                    SizedBox(
                                                                        height:
                                                                            2),
                                                                    Text(
                                                                      _comments[index2]
                                                                              .data[
                                                                          'body'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black,
                                                                        // iransans
                                                                        fontFamily:
                                                                            'iransans',
                                                                      ),
                                                                    ),
                                                                    // send reply button
                                                                    SizedBox(
                                                                        height:
                                                                            1),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // show dialog to send comment
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                title: Center(
                                                                                  child: Text('پاسخ خود را بنویسید'),
                                                                                ),
                                                                                content: TextFormField(
                                                                                  controller: _replyController,
                                                                                  decoration: InputDecoration(
                                                                                    border: OutlineInputBorder(),
                                                                                  ),
                                                                                ),
                                                                                actions: [
                                                                                  Center(
                                                                                    child: RaisedButton(
                                                                                      onPressed: () {
                                                                                        print('piuj' + index2.toString());
                                                                                        // send comment
                                                                                        _futureReply = Services.sendReplyGame(_comments[index2].data['id'], _replyController.text);
                                                                                        _futureReply.then((value) {
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
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            'پاسخ',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              // color: Colors.black,
                                                                              // iransans
                                                                              fontFamily: 'iransans',
                                                                            ),
                                                                          ),
                                                                          // 5 box
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Icon(
                                                                            Icons.reply,
                                                                            // color:
                                                                                // Colors.black,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    // replies
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    ListView.builder(
                                                                        physics: NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        itemCount: _comments[index2].data['answers'].length,
                                                                        itemBuilder: (context, index3) {
                                                                          return Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 40),
                                                                            width:
                                                                                double.infinity,
                                                                            // height: 150,
                                                                            child:
                                                                                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                              Row(children: [
                                                                                Container(
                                                                                  width: 40,
                                                                                  height: 40,
                                                                                  child: Image.asset(Images.profile),
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                  Text(
                                                                                    // 'username',
                                                                                    _comments[index2].data['answers'][index3]['username'],
                                                                                    style: TextStyle(
                                                                                      fontSize: 15,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontFamily: 'iransans',
                                                                                    ),
                                                                                  ),
                                                                                  Text('در تاریخ 1398/12/12',
                                                                                      style: TextStyle(
                                                                                        fontSize: 15,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontFamily: 'iransans',
                                                                                      ))
                                                                                ])
                                                                              ]),
                                                                              // SizedBox(height: 0),
                                                                              Text(
                                                                                _comments[index2].data['answers'][index3]['body'],
                                                                                style: TextStyle(
                                                                                  fontSize: 15,
                                                                                  // color: Colors.black,
                                                                                  // iransans
                                                                                  fontFamily: 'iransans',
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                          );
                                                                        }),
                                                                  ]));
                                                        }));
                                              } else {
                                                // circle
                                                return Container(
                                                  height: 150,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              }
                                            }),
                                        // white line
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 20),
                                      ]));
                            }),
                      ),
                    ]),
                  )),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
