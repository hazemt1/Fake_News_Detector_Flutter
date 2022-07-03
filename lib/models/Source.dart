
class Source {

  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

	Source.fromJsonMap(Map<String, dynamic> map):
		id = map["id"] ?? '' ,
		name = map["name"] ?? '',
		description = map["description"] ?? '',
		url = map["url"] ?? '',
		category = map["category"] ?? '',
		language = map["language"] ?? '',
		country = map["country"] ?? '';

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		data['url'] = url;
		data['category'] = category;
		data['language'] = language;
		data['country'] = country;
		return data;
	}
}
