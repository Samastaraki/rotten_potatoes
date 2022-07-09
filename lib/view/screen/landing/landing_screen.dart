import 'package:flutter/material.dart';
import 'package:rotten_potatoes/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late Future<List<Game>> _future;
  List<Game> _searchResults = [];
  @override
  Widget build(BuildContext context) {
    _future = Services.getGame('');

    return FutureBuilder<List<Game>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final _games = snapshot.data!;
            _games.sort((a, b) => b.rating.compareTo(a.rating));
            return Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.only(
                      top: 80,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      children: [
                        // title of page
                        Text(
                          'بازی های برتر',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // list of games
                        Expanded(
                          child: ListView.builder(
                            itemCount: _games.length,
                            itemBuilder: (context, index) {
                              final _game = _games[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/game_details',
                                      arguments: {
                                        'name': _game.name,
                                        'rating': _game.rating,
                                        'description': _game.description,
                                        'subs': _game.subs,
                                        'image': (_game.image != null)
                                            ? _game.image
                                            : 'https://img.pikbest.com/templates/20210329/bg/a99b1b110c852.jpg!c1024wm0',
                                      });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.grey.withOpacity(0.5)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        // image of game
                                        Container(
                                          width: 60,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              (_game.image != null)
                                                  ? _game.image
                                                  : 'https://img.pikbest.com/templates/20210329/bg/a99b1b110c852.jpg!c1024wm0',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // 20
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // title of game
                                              Text(
                                                _game.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // description of game
                                              Text(
                                                _game.description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              RatingBar.builder(
                                                ignoreGestures: true,
                                                unratedColor: Colors.grey,
                                                initialRating:
                                                    double.parse(_game.rating),
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
