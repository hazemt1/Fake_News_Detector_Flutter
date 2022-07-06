import 'dart:convert';

import 'package:fake_news/models/News.dart';
import 'package:http/http.dart' as http;

class NewsAPI{
  static const String mainUrl ='sheltered-river-61583.herokuapp.com';
  static Future<List<News>> getSearchedNews() async {
    final uri = Uri.https(mainUrl, 'api/v1/news/recentlySearchedNews');
    List<News> news = [];
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(uri, headers: headers);
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      body['data'].forEach((x) {
        news.add(News.fromJsonMap(x));
      });
      return news;
    } else {
      throw Exception(response.body);
    }
  }
  static Future<List<News>> getHistory(String token) async {
    final uri = Uri.https(mainUrl, 'api/v1/news/userHistory');
    List<News> news = [];
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(uri, headers: headers);
    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 400) {
      body['data'].forEach((x) {
        news.add(News.fromJsonMap(x));
      });
      return news;
    } else {
      throw Exception(response.body);
    }
  }
  static Future deleteNews(String token,String id) async {
    final uri = Uri.https(mainUrl, 'api/v1/news/$id');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return;
    } else {
      return throw response.body;
    }
  }
}