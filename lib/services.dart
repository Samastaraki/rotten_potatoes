import 'dart:convert';

import 'package:rotten_potatoes/utill/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Services {
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '0');
    print(token);
    return token;
    // await prefs.setInt('counter', counter);
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
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
          return status! < 500;
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return UserRegister.fromJson(response.data, response.statusCode!);
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
          'Authorization': 'token ' +
              'bb305ef3bad090dab3c1b184c637082195b5ffb721d25c6049d29cc42c33357f',
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

  // update user
  static Future<UpdateUser> updateUser(
      String username, String fullname, String email) async {
    final response = await Dio().put(
      'http://185.141.107.81:1111/api/Profile/update/admin20/',
      data: {
        'fullname': fullname,
        'username': username,
        'email': email,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'token ' +
              'bb305ef3bad090dab3c1b184c637082195b5ffb721d25c6049d29cc42c33357f',
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
  final String user;
  final message;
  // final String status;

  UserRegister(
      {required this.token, required this.user, required this.message});

  factory UserRegister.fromJson(Map<String, dynamic> json, int statusCode) {
    if (statusCode == 200) {
      return UserRegister(
        token: json['token'],
        user: json['user'],
        message: 'ok',
      );
    } else {
      return UserRegister(
        token: '0',
        user: '0',
        message: json,
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
        image: json['image']);
  }
}

class Game {
  // name, description, rating, subscribers
  final String name;
  final String description;
  final String rating;
  final int subs;
  // final data;

  // constructor
  Game({
    required this.name,
    required this.description,
    required this.rating,
    required this.subs,
    // required this.data
  });

  // factory
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'],
      description: json['description'],
      rating: json['average_rating'].toString(),
      subs: json['get_total_subs'],
      // data: json,
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

class UpdateUser {
  final int statusCode;

  UpdateUser({required this.statusCode});

  factory UpdateUser.fromJson(Map<String, dynamic> json, int statusCode) {
    return UpdateUser(
      statusCode: statusCode,
    );
  }
}
