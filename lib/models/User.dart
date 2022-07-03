class User{
  String? id;
  String? name;
  String? email;
  String? password;

  User({this.name,this.id,this.email,this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['url'] = password;
    return data;
  }

  User.fromJsonMap(Map<String, dynamic> map):
        id = map["id"] ?? '' ,
        name = map["name"] ?? '',
        email = map["email"] ?? '',
        password = map["password"] ?? '';


  logout(){

  }

}