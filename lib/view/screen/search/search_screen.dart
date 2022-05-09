import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:rotten_potatoes/utill/images.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Game>> _future;
  List<Game> _searchResults = [];
  List<Game> _searchResultsTemp = [];
  // controllers
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // edit email textfield
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            // width: 200,
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
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // SizedBox(width: 20),
                          // search button
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            // search Icon button
                            child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _future =
                                      Services.getGame(_searchController.text);
                                  _future.then((value) {
                                    for (var i = 0; i < value.length; i++) {
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
                                }),
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
                    SizedBox(height: 20),
                    // white line
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    // list view of games that match the search text field text and their ratings
                    Expanded(
                      // width: double.infinity,
                      // height: 500,
                      child: ListView.builder(
                          // shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            print(_searchResults.length);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                // color: Colors.grey,
                                // width: 120,
                                // height: 150,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/game_details',
                                      arguments: {
                                        'name': _searchResults[index].name,
                                        'rating': _searchResults[index].rating,
                                        'description':
                                            _searchResults[index].description,
                                        'subs': _searchResults[index].subs,
                                      });
                                },
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
                                      _searchResults[index].name,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'iransans',
                                      ),
                                    ),
                                    // game rating
                                    Text(
                                      _searchResults[index].rating.toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'iransans',
                                      ),
                                    ),
                                    // 10
                                    // SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ]))),
    );
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
