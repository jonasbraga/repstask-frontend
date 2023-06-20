import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reptask/configs/config.dart';
import 'package:reptask/models/login_model.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/utils/user_preferences.dart';

class LoginController {
  Future<UserModel?> createLogin(LoginModel newLogin) async {
    final Uri uri = Uri.parse('http://$backendAdress/login');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var data = {
      'rep': newLogin.rep,
      'email': newLogin.usuario,
      'password': newLogin.senha,
    };
    var body = json.encode(data);
    debugPrint(body);
    final response = await http.post(uri, headers: headers, body: body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body != null) {
        UserModel user = UserModel(
          id: body['id'],
          name: body['name'],
          email: body['email'],
          imagePath: body['photo'],
          userType: body['user_type'],
          nickname: body['nickname'],
          password: body['password'],
          repId: body['reps_id'],
          nomeRep: body['nomeRep'],
          userPoints: body['userPoints'],
          userDoneTasks: body['userDoneTasks'],
          token: body['token'],
          // isDarkMode: body['isDarkMode'],
        );
        if (user.imagePath == null) {
          final userPrefer = UserPreferences.myUser;
          user.imagePath = userPrefer.imagePath;
        }
        return user;
      } else {
        return null;
      }
    }
    // return (user);
  }
}
