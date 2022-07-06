class News{
  String description;
  String? id;
  String date;
  double acc;
  News({required this.description,required this.date, this.id, required this.acc});

  News.fromJsonMap(Map<String, dynamic> map):
        id = map["_id"] ?? '' ,
        description = map["description"] ?? '',
        date = map["date"] ?? '',
        acc = map["status_Percent"] ?? 1;
}