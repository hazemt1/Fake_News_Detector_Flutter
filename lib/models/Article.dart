

import 'package:fake_news/models/Source.dart';

class Article {

  Source source;
  Object author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

	Article.fromJsonMap(Map<String, dynamic> map):
		source = Source.fromJsonMap(map["source"]),
		author = map["author"]!=null?map["author"]:'',
		title = map["title"]!=null?map["title"]:'',
		description = map["description"]!=null?map["description"]:'',
		url = map["url"]!=null?map["url"]:'',
		urlToImage = map["urlToImage"]!=null?map["urlToImage"]:'',
		publishedAt = map["publishedAt"]!=null?map["publishedAt"]:'',
		content = map["content"]!=null?map["content"]:'';


}
