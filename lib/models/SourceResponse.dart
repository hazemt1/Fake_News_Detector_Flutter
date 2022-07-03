

import 'package:fake_news/models/Source.dart';

class SourceResponse {

  String status;
  List<Source> sources;

	SourceResponse.fromJsonMap(Map<String, dynamic> map): 
		status = map["status"],
		sources = List<Source>.from(map["sources"].map((it) => Source.fromJsonMap(it)));


}
