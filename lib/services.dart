import 'dart:convert';
import 'dart:io';

import 'package:rotten_potatoes/utill/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Services {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '0');
    print(token);
    return token;
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // user profile
  static Future<UserProfile> getUserProfileP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfile = (prefs.getString('userProfile') ?? '0');
    return UserProfile.fromJson(json.decode(userProfile), 200);
  }

  static setUserProfileP(UserProfile userProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', json.encode(userProfile));
  }

  static updateUserProfileP(
      String username, String fullname, String email, String sex, String image) async {
    UserProfile userProfileTemp = await getUserProfileP();
    UserProfile userProfile = UserProfile(
        id: userProfileTemp.id,
        username: username,
        email: email,
        fullname: fullname,
        sex: sex,
        image: image);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', json.encode(userProfile));
  }

  static Future<UserLogin> createUserLogin(
      String email, String password) async {
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/login/',
      data: {
        'username': email,
        'password': password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return UserLogin.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  static Future<UserRegister> createUserRegister(
      String username, String password, String email) async {
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/register/',
      data: {
        'username': username,
        'password': password,
        'email': email,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 501;
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return UserRegister.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // search user
  static Future<List<UserProfile>> searchUser(String searched) async {
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/search_users/?name=$searched',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<UserProfile>.from(response.data
          .map((x) => UserProfile.fromJson(x, response.statusCode!)));
    } else {
      throw Exception('Failed to load internet');
    }
  }

  static Future<UserProfile> getUserProfile(String username) async {
    print(username);
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/profile/$username/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return UserProfile.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //subscribe game
  static Future<bool> subscribeGame(String gameName) async {
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/subscribe/$gameName/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 200) {
      return false;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //is subscribe game
  static Future<isSubscribe> isSubscribeGame(String gameName) async {
    print(gameName);
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/is_subscribed/$gameName/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return isSubscribe.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // add game
  static Future<GameAdd> addGame(
      String name, String description, File image) async {
    String fileName = image.path.split('/').last;
    FormData data = FormData.fromMap({
      'name': name,
      'description': description,
      'image': await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/add_game/',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      return GameAdd.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  static Future<GameAdd> addGame1(String name, String description) async {
    // String fileName = image.path.split('/').last;
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/add_game/',
      data: {
        'name': name,
        'description': description,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      return GameAdd.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // get game
  static Future<List<Game>> getGame(String gameName) async {
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/search_game/?name=$gameName',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      // return Game.fromJson(response.data, response.statusCode!);
      return List<Game>.from(response.data.map((data) => Game.fromJson(data)));
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // get review game
  static Future<List<ReviewGame>> getReviewGame(String gameName) async {
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/ReviewGame/$gameName/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      // return Game.fromJson(response.data, response.statusCode!);
      return List<ReviewGame>.from(
          response.data.map((data) => ReviewGame.fromJson(data)));
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // get post game
  static Future<List<PostGame>> getPostGame(String gameName) async {
    // print(gameName);
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/get_posts_game/$gameName',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      // print('object');
      // return Game.fromJson(response.data, response.statusCode!);
      return List<PostGame>.from(response.data
          .map((data) => PostGame.fromJson(data, response.statusCode!)));
    } else {
      throw Exception('Failed to load internet');
    }
  }

  //get user review
  static Future<List<ReviewUser>> getUserReview(String username) async {
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/get_user_reviews/$username/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<ReviewUser>.from(
          response.data.map((data) => ReviewUser.fromJson(data)));
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // get comment game
  static Future<List<CommentGame>> getCommentGame(int PostID) async {
    final response = await Dio().get(
      'http://185.141.107.81:1111/api/comments/$PostID/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<CommentGame>.from(response.data
          .map((data) => CommentGame.fromJson(data, response.statusCode!)));
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // send comment game
  static Future<CommentGame> sendCommentGame(int PostID, String comment) async {
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/comment/create/',
      data: {
        'post': PostID,
        'body': comment,
        'user': (await getUserProfileP()).id,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201) {
      return CommentGame.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // send Reply game
  static Future<CommentGame> sendReplyGame(int commentID, String reply) async {
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/reply/create/',
      data: {
        'comment': commentID,
        'body': reply,
        'user': (await getUserProfileP()).id,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201) {
      return CommentGame.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // send review game
  static Future<Review> sendReviewGame(
      String gameName, String review, double score, String user) async {
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/ReviewGame/create/$gameName/',
      data: {
        'rating': score,
        'description': review,
        'user': user,
        'game': gameName,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201) {
      return Review.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // send post game
  static Future<PostGame> sendPostGame(String gameName, String content) async {
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/create_post/',
      data: {
        'name': gameName,
        'content': content,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 201) {
      return PostGame.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // update user
  static Future<UpdateUser> updateUser(
      String username, String fullname, String email, String sex, String image) async {
    print("s" + username);
    final response = await Dio().put(
      'http://185.141.107.81:1111/api/Profile/update/$username/',
      data: {
        'fullname': fullname,
        'username': username,
        'email': email,
        'profile_picture_url': image,
        'sex': sex,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return UpdateUser.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // upload image
  static Future<UploadImage> uploadImage(File image) async {
    String fileName = image.path.split('/').last;
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });
    final response = await Dio().post(
      'http://185.141.107.81:1111/api/upload_image/',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token ' + await getToken(),
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return UploadImage.fromJson(response.data, response.statusCode!);
    } else {
      throw Exception('Failed to load internet');
    }
  }
}

class UserLogin {
  final String data;
  // final String status;

  UserLogin({required this.data});

  factory UserLogin.fromJson(Map<String, dynamic> json, int statusCode) {
    if (statusCode == 200) {
      return UserLogin(
        data: json['token'],
      );
    } else {
      return UserLogin(
        data: '0',
      );
    }
  }
}

class UserRegister {
  final String token;
  final user;
  // final message;
  // final String status;

  UserRegister(
      {required this.token, required this.user});

  factory UserRegister.fromJson(Map<String, dynamic> json, int statusCode) {
    if (statusCode == 200) {
      return UserRegister(
        token: json['token'],
        user: json['user'],
        // message: 'ok',
      );
    } else {
      return UserRegister(
        token: '0',
        user: '0',
        // message: json,
      );
    }
  }
}

class UserProfile {
  final int id;
  final String username;
  final String email;
  final String fullname;
  final String sex;
  final image;

  UserProfile(
      {required this.id,
      required this.username,
      required this.email,
      required this.fullname,
      required this.sex,
      required this.image});

  factory UserProfile.fromJson(Map<String, dynamic> json, int statusCode) {
    return UserProfile(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        fullname: json['fullname'],
        sex: json['sex'],
        image: json['profile_picture_url']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'fullname': fullname,
        'sex': sex,
        'profile_picture_url': image,
      };
}

class Game {
  // name, description, rating, subscribers
  final String name;
  final String description;
  final String rating;
  final int subs;
  final image;
  // final data;

  // constructor
  Game({
    required this.name,
    required this.description,
    required this.rating,
    required this.subs,
    required this.image,
    // required this.data
  });

  // factory
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'],
      description: json['description'],
      rating: json['average_rating'].toString(),
      subs: json['get_total_subs'],
      image: json['profile_picture_url'],
      // data: json,
    );
  }
}

class GameAdd {
  // name, description, image
  final data;
  final int statusCode;

  // constructor
  GameAdd({
    required this.data,
    required this.statusCode,
  });

  // factory
  factory GameAdd.fromJson(Map<String, dynamic> json, int statusCode) {
    return GameAdd(
      data: json,
      statusCode: statusCode,
    );
  }
}

class isSubscribe {
  final data;
  final int statusCode;

  // constructor
  isSubscribe({
    required this.data,
    required this.statusCode,
  });

  // factory
  factory isSubscribe.fromJson(Map<String, dynamic> json, int statusCode) {
    return isSubscribe(
      data: json,
      statusCode: statusCode,
    );
  }
}

// review game
class ReviewGame {
  // username, rating, description
  final String username;
  final String rating;
  final String description;

  // constructor
  ReviewGame({
    required this.username,
    required this.rating,
    required this.description,
  });

  // factory
  factory ReviewGame.fromJson(Map<String, dynamic> json) {
    return ReviewGame(
      username: json['username'],
      rating: json['rating'].toString(),
      description: json['description'],
    );
  }
}

class PostGame {
  final data;
  final int statusCode;

  PostGame({
    required this.data,
    required this.statusCode,
  });

  factory PostGame.fromJson(Map<String, dynamic> json, int statusCode) {
    return PostGame(
      data: json,
      statusCode: statusCode,
    );
  }
}

// review user
class ReviewUser {
  // game, rating, description
  final String game;
  final double rating;
  final String description;

  // constructor
  ReviewUser({
    required this.game,
    required this.rating,
    required this.description,
  });

  // factory
  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      game: json['game_name'],
      rating: double.parse(json['rating'].toString()),
      description: json['description'].toString(),
    );
  }
}

class Review {
  final data;
  final int statusCode;

  Review({required this.data, required this.statusCode});

  factory Review.fromJson(Map<String, dynamic> json, int statusCode) {
    return Review(
      data: json,
      statusCode: statusCode,
    );
  }
}

class CommentGame {
  final data;
  final int statusCode;

  CommentGame({required this.data, required this.statusCode});

  factory CommentGame.fromJson(Map<String, dynamic> json, int statusCode) {
    return CommentGame(
      data: json,
      statusCode: statusCode,
    );
  }
}

class UpdateUser {
  final int statusCode;
  final data;

  UpdateUser({required this.statusCode, required this.data});

  factory UpdateUser.fromJson(Map<String, dynamic> json, int statusCode) {
    return UpdateUser(
      statusCode: statusCode,
      data: json,
    );
  }
}

class UploadImage {
  final data;
  final int statusCode;

  UploadImage({required this.data, required this.statusCode});

  factory UploadImage.fromJson(Map<String, dynamic> json, int statusCode) {
    return UploadImage(
      data: json,
      statusCode: statusCode,
    );
  }
}
