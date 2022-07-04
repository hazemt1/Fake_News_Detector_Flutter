import 'package:fake_news/bloc/user/user_bloc.dart';
import 'package:fake_news/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class User{
  String? id;
  String? name;
  String? email;
  String? password;

  User({this.name,this.id,this.email,this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if(id!=null) {
      data['id'] = id;
    }
    if(name!=null) {
      data['name'] = name;
    }
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  User.fromJsonMap(Map<String, dynamic> map):
        id = map["_id"] ?? '' ,
        name = map["name"] ?? '',
        email = map["email"] ?? '',
        password = map["password"] ?? '';


  static logout(BuildContext context){
    Preferences.removeUser();
    BlocProvider.of<UserBloc>(context).add(const UserLogout());
  }

}