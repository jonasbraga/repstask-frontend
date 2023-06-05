import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/models/user_model.dart';
import '../configs/config.dart';

class UserController {
  Future createNewUser(UserModel userData) async {
    final Uri uri = Uri.parse('http://$backendAdress/users');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var data = {
      'name': userData.name,
      'email': userData.email,
      'nickname': userData.nickname,
      'password': userData.password,
      'user_type': 1,
      'reps_id': userData.repId
    };
    var body = json.encode(data);

    await http.post(uri, headers: headers, body: body);
  }
}
