import 'dart:convert';

import 'package:fake_news/models/Review.dart';
import 'package:http/http.dart' as http;

class ReviewApi {
  static const String mainUrl = 'sheltered-river-61583.herokuapp.com';
  static Future<List<Review>> getAllReviews(String token) async {
    final uri = Uri.https(mainUrl, 'api/v1/reviews/getAllReviews');
    List<Review> reviews = [];
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(uri, headers: headers);
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      body['data']['reviews'].forEach((x) {
        reviews.add(Review.fromJsonMap(x));
      });
      return reviews;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<Review?> getReview(String token) async {
    final uri = Uri.https(mainUrl, 'api/v1/reviews/getReview');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(uri, headers: headers);
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return Review.fromJsonMap(body['data']['data']);
    } else if (body['message'] == "You didnt review yet") {
      return null;
    } else {
      throw Exception(response.body);
    }
  }
  static Future<String> createReview(String token,Review review) async {
    final uri = Uri.https(mainUrl, 'api/v1/reviews/createReview');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(uri,body: jsonEncode(review.toJson()), headers: headers);
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return '';
    }  else {
      return body['message'];
    }
  }
  static Future<String> updateReview(String token,Review review) async {
    final uri = Uri.https(mainUrl, 'api/v1/reviews/updateReview');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.patch(uri,body: jsonEncode(review.toJson()), headers: headers);
    final body = jsonDecode(response.body);
    print(body);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return '';
    }  else {
      return body['message'];
    }
  }

  static Future deleteReview(String token) async{
    final uri = Uri.https(mainUrl, 'api/v1/reviews/deleteReview');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return ;
    }  else {
      return jsonDecode(response.body)['message'];
    }
  }

}
