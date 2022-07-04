import 'dart:convert';
import '../models/User.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  static const String mainUrl = 'sheltered-river-61583.herokuapp.com';

  static Future<List<String>> login( User user) async {
    List<String> info = List.empty(growable: true);
    final uri = Uri.https(mainUrl, 'api/v1/users/login');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var body = user.toJson();

    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);


    if (response.statusCode >= 200 && response.statusCode < 400) {
      var decoded = jsonDecode(response.body);
      String token = decoded['token'];

      User loggedUser = User.fromJsonMap(decoded['data']['user']);

      info.add(token);
      info.add(loggedUser.name!);
      info.add(loggedUser.email!);
      info.add(loggedUser.id!);
      return info;
    } else if (response.statusCode >= 400) {
      info.add(jsonDecode(response.body)['message']);
      return info;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<String>> signup( User user) async {
    final uri = Uri.https(mainUrl, 'api/v1/users/signup');
    List<String> info = List.empty(growable: true);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var body = user.toJson();
    print(body);
    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 400) {
      var decoded = jsonDecode(response.body);
      User loggedUser = User.fromJsonMap(decoded['data']['user']);
      String token = decoded['token'];
      info.add(token);
      info.add(loggedUser.name!);
      info.add(loggedUser.email!);
      info.add(loggedUser.id!);
      return info;
    } else if (response.statusCode >= 400) {
      info.add(jsonDecode(response.body)['message']);
      return info;
    }else {
      throw Exception(response.body);
    }
  }

  static User? getMe(String token) {
    final uri = Uri.https(mainUrl, 'api/v1/users/getMe');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    http.get(uri, headers: headers).then(
      (response) {
        if (response.statusCode >= 200 && response.statusCode < 400) {
          var decoded = jsonDecode(response.body);
          User loggedUser = User.fromJsonMap(decoded['data']);
          return loggedUser;
        } else {
          throw Exception(response.body);
        }
      },
    );
    return null;
  }
}
