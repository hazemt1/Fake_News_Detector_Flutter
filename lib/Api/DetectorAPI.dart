import 'dart:convert';
import 'package:http/http.dart' as http;

class DetectorAPI{
  static const String mainUrl ='sheltered-river-61583.herokuapp.com';
  static Future<double> userDetect(String text,String token)async{
    final uri = Uri.https(mainUrl, 'api/v1/news/userDetectNews');
    Map<String,String> headers = {
      'Content-Type':'application/json',
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = <String, dynamic>{};
    data["description"]=text;
    var body = jsonEncode(data) ;
    final response = await http.post(uri,body: body ,headers: headers);
    // print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      var decoded =jsonDecode(response.body)["result_Percent"];
      return decoded;
    }
    else if(response.statusCode == 401) {

    }
    else {
      throw Exception(response.body);
    }
    return Future(() => 0.00001);
  }
  static Future<double> guestDetect(String text)async{
    final uri = Uri.https(mainUrl, 'api/v1/news/guestDetectNews');
    Map<String,String> headers = {
      'Content-Type':'application/json',
    };
    final Map<String, dynamic> data = <String, dynamic>{};
    data["description"]=text;
    var body = jsonEncode(data) ;
    final response = await http.post(uri,body: body ,headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      var decoded =jsonDecode(response.body)["result_Percent"];
      return decoded;
    }
    else if(response.statusCode == 401) {

    }
    else {
      throw Exception(response.body);
    }
    return Future(() => 0.00001);
  }
}