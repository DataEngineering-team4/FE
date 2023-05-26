import 'dart:convert';

import 'package:ai4005_fe/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<String> loginUser({
  required String username,
  required String password,
  required context,
}) async {
  String res = "Some error occured";

  final response =
      await http.post(Uri.parse('http://www.det4.site:5000/user/login/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "username": username,
            "password": password,
          }));

  final jsonResponse = jsonDecode(response.body);
  res = jsonResponse["status"];
  print(res);

  if (response.statusCode == 200) {
    Provider.of<UserProvider>(context, listen: false).setUser(
        jsonResponse["data"]["id"],
        jsonResponse["data"]["username"],
        jsonResponse["data"]["email"]);
  }

  return res;
}

Future<String> signupUser({
  required String username,
  required String password,
  required String email,
  required context,
}) async {
  String res = "Some error occured";

  final response =
      await http.post(Uri.parse('http://www.det4.site:5000/user/signup/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "username": username,
            "password": password,
            "email": email,
          }));

  final jsonResponse = jsonDecode(response.body);
  res = jsonResponse["status"];
  if (response.statusCode == 200) {
    Provider.of<UserProvider>(context, listen: false).setUser(
        jsonResponse["data"]["id"],
        jsonResponse["data"]["username"],
        jsonResponse["data"]["email"]);
  }
  return res;
}
