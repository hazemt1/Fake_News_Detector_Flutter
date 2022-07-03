

import 'package:fake_news/models/Article.dart';

class NewsResponse {

  String status;
  int totalResults;
  List<Article> articles;

	NewsResponse.fromJsonMap(Map<String, dynamic> map): 
		status = map["status"],
		totalResults = map["totalResults"],
		articles = List<Article>.from(map["articles"].map((it) => Article.fromJsonMap(it)));


}