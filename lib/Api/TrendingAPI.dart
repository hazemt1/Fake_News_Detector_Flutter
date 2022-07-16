import 'dart:convert';
import 'package:fake_news/models/NewsResponse.dart';
import 'package:http/http.dart' as http;


// Future<SourceResponse> getSources(String category, String lang) async {
//   // https://newsapi.org/v2/top-headlines/sources?apiKey=3ed0d5dca43940c1b65140d0ab1270eb&category=sports
//   final uri = Uri.https('newsapi.org', '/v2/top-headlines/sources', {
//     // 'apiKey': '3ed0d5dca43940c1b65140d0ab1270eb',
//     'apiKey': '8c4d7ba02aaa41d195908ecef536978c',
//     'category': category,
//     'language': lang
//   });
//   final response = await http.get(uri);
//   // print(response.body);
//   if (response.statusCode >= 200 && response.statusCode < 300) {
//     return SourceResponse.fromJsonMap(jsonDecode(response.body));
//   } else {
//     throw Exception(response.body);
//   }
// }

Future<NewsResponse> getTrending() async {
  // https://newsapi.org/v2/top-headlines/sources?apiKey=3ed0d5dca43940c1b65140d0ab1270eb&category=sports
  const String mainUrl ='sheltered-river-61583.herokuapp.com';
  final uri = Uri.https(mainUrl, 'api/v1/news/trendyNews');
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  final response = await http.get(uri, headers: headers);
  // print(response.body);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return NewsResponse.fromJsonMap(jsonDecode(response.body)['data']);
  } else {
    throw Exception(response.body);
  }
}