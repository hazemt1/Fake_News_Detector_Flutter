class Review {
  String? id;
  String? userName;
  int rate;
  String review;
  String? date;
  Review({
    this.id,
    this.userName,
    required this.review,
    required this.rate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) {
      data['_id'] = id;
    }
    if (userName != null) {
      data['name'] = userName;
    }
    data['rating'] = rate;
    data['review'] = review;
    return data;
  }

  Review.fromJsonMap(Map<String, dynamic> map)
      : id = map["_id"] ?? '',
        userName = map["name"] ?? '',
        rate = map["rating"] ?? 0,
        date = map["createdAt"] ?? '',
        review = map["review"] ?? '';
}