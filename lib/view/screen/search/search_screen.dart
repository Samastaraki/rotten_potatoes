import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/colorR.dart';
import 'package:rotten_potatoes/utill/images.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Game>> _future;
  late Future<List<UserProfile>> _futureUser;
  List<Game> _searchResults = [];
  List<UserProfile> _searchUserResults = [];
  List<Game> _searchResultsTemp = [];
  List<UserProfile> _searchUserResultsTemp = [];
  int _page = 1;
  bool _isLoading = false;
  // controllers
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 70),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // edit email textfield
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              // width: 100,
                              child: Container(
                                height: 50,
                                child: TextFormField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'جستجو',
                                    hintTextDirection: TextDirection.rtl,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'iransans',
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // search button
                            (_isLoading == false)
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorR.text,
                                    ),
                                    // search Icon button
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          _future = Services.getGame(
                                              _searchController.text);
                                          _future.then((value) {
                                            for (var i = 0;
                                                i < value.length;
                                                i++) {
                                              _searchResultsTemp.add(value[i]);
                                            }
                                            setState(() {
                                              _searchResults = [];
                                              for (var i = 0;
                                                  i < _searchResultsTemp.length;
                                                  i++) {
                                                _searchResults
                                                    .add(_searchResultsTemp[i]);
                                              }
                                              print(_searchResults.length);
                                            });
                                          });
                                          _searchResultsTemp = [];
                                          _futureUser = Services.searchUser(
                                              _searchController.text);
                                          _futureUser.then((value) {
                                            for (var i = 0;
                                                i < value.length;
                                                i++) {
                                              _searchUserResultsTemp
                                                  .add(value[i]);
                                            }
                                            setState(() {
                                              _searchUserResults = [];
                                              for (var i = 0;
                                                  i <
                                                      _searchUserResultsTemp
                                                          .length;
                                                  i++) {
                                                _searchUserResults.add(
                                                    _searchUserResultsTemp[i]);
                                              }
                                              print(_searchUserResults.length);
                                              _isLoading = false;
                                            });
                                          });
                                          _searchUserResultsTemp = [];
                                        }),
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorR.text,
                                    ),
                                    // search Icon button
                                    child: Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // game list
                      // Container(
                      //     height: 200,
                      //     child: ListView(
                      //         scrollDirection: Axis.horizontal,
                      //         children: [
                      //           // game 1
                      //           Container(
                      //             width: 120,
                      //             height: 160,
                      //             child: Image.asset(Images.farcry6),
                      //           ),
                      //           SizedBox(width: 20),
                      //           // game 2
                      //           Container(
                      //             width: 120,
                      //             height: 160,
                      //             child: Image.asset(Images.farcry6),
                      //           ),
                      //           SizedBox(width: 20),
                      //           // game 3
                      //           Container(
                      //             width: 120,
                      //             height: 160,
                      //             child: Image.asset(Images.farcry6),
                      //           ),
                      //           SizedBox(width: 20),
                      //         ]))
                      // SizedBox(height: 20),
                      // white line
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(height: 5),
                      // users or games toggle
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // users toggle
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _page = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      (_page == 1) ? ColorR.text : Colors.grey,
                                ),
                                child: Center(
                                  child: Text(
                                    'کاربران',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'iransans',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // games toggle
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _page = 2;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      (_page == 2) ? ColorR.text : Colors.grey,
                                ),
                                child: Center(
                                  child: Text(
                                    'بازی ها',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'iransans',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      // list view of games that match the search text field text and their ratings
                      (_page == 2)
                          ? Expanded(
                              // width: double.infinity,
                              // height: 500,
                              child: ListView.builder(
                                  // shrinkWrap: true,
                                  // scrollDirection: Axis.horizontal,
                                  itemCount: _searchResults.length,
                                  itemBuilder: (context, index) {
                                    print(_searchResults.length);
                                    return Container(
                                      // height: 120,
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        // color: Colors.grey,
                                        // width: 120,
                                        // height: 150,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/game_details',
                                              arguments: {
                                                'name':
                                                    _searchResults[index].name,
                                                'rating': _searchResults[index]
                                                    .rating,
                                                'description':
                                                    _searchResults[index]
                                                        .description,
                                                'subs':
                                                    _searchResults[index].subs,
                                                'image': (_searchResults[index]
                                                            .image !=
                                                        null)
                                                    ? _searchResults[index]
                                                        .image
                                                    : 'https://img.pikbest.com/templates/20210329/bg/a99b1b110c852.jpg!c1024wm0',
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              // game image
                                              Container(
                                                width: 60,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        (_searchResults[index]
                                                                    .image !=
                                                                null)
                                                            ? (_searchResults[
                                                                    index]
                                                                .image
                                                                .toString())
                                                            : ('https://img.pikbest.com/templates/20210329/bg/a99b1b110c852.jpg!c1024wm0')),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    // game image
                                                    // Container(
                                                    //   width: 120,
                                                    //   height: 120,
                                                    //   decoration: BoxDecoration(
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(10),
                                                    //     image: DecorationImage(
                                                    //         image: NetworkImage(
                                                    //             _searchResults[index]
                                                    //                 .imageUrl),
                                                    //         fit: BoxFit.cover),
                                                    //   ),
                                                    // ),
                                                    // game name
                                                    Text(
                                                      _searchResults[index]
                                                          .name,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontFamily: 'iransans',
                                                      ),
                                                    ),
                                                    // 10
                                                    SizedBox(height: 10),
                                                    // game rating
                                                    // Text(
                                                    //   _searchResults[index]
                                                    //       .rating
                                                    //       .toString(),
                                                    //   style: TextStyle(
                                                    //     fontSize: 17,
                                                    //     fontWeight: FontWeight.normal,
                                                    //     fontFamily: 'iransans',
                                                    //   ),
                                                    // ),
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      unratedColor: Colors.grey,
                                                      initialRating:
                                                          double.parse(
                                                              _searchResults[
                                                                      index]
                                                                  .rating),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 20,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    // 10
                                                    // SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: _searchUserResults.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            // color: Colors.grey,
                                            // width: 120,
                                            // height: 150,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/user_details',
                                                  arguments: {
                                                    'id': _searchUserResults[
                                                            index]
                                                        .id,
                                                    'username':
                                                        _searchUserResults[
                                                                index]
                                                            .username,
                                                    'email': _searchUserResults[
                                                            index]
                                                        .email,
                                                    'fullname':
                                                        _searchUserResults[
                                                                index]
                                                            .fullname,
                                                    'sex': _searchUserResults[
                                                            index]
                                                        .sex,
                                                    'profile_picture_url':
                                                        _searchUserResults[
                                                                index]
                                                            .image,
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Row(
                                                children: [
                                                  // game image
                                                  (_searchUserResults[index]
                                                              .image !=
                                                          null)
                                                      ? Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image: DecorationImage(
                                                                image: (NetworkImage(
                                                                    _searchUserResults[
                                                                            index]
                                                                        .image))),
                                                          ))
                                                      : Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: AssetImage(
                                                                        Images
                                                                            .profile),
                                                                  ))),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(children: [
                                                      //username
                                                      Text(
                                                        _searchUserResults[
                                                                index]
                                                            .username,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily:
                                                              'iransans',
                                                        ),
                                                      ),
                                                      Text(
                                                        _searchUserResults[
                                                                index]
                                                            .fullname,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily:
                                                              'iransans',
                                                        ),
                                                      ),
                                                      // 10
                                                      SizedBox(height: 10),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            )));
                                  }),
                            )
                    ]))));
  }
}

// class GameO {
//   // name, description, rating, subscribers
//   final String name;
//   final String description;
//   final double rating;
//   final int subscribers;

//   GameO(this.name, this.description, this.rating, this.subscribers);
// }
