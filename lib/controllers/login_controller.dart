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
      'email': newLogin.email,
      'password': newLogin.senha,
    };
    var body = json.encode(data);
    debugPrint(body);
    final response = await http.post(uri, headers: headers, body: body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body != null) {
        String token = body['token'];

        UserModel user = UserModel(
          id: body['user']['id'],
          name: body['user']['name'],
          email: body['user']['email'],
          imagePath: body['user']['photo'],
          userType: body['user']['user_type'],
          nickname: body['user']['nickname'],
          password: body['user']['password'],
          repId: body['user']['reps_id'],
          nomeRep: body['user']['rep_name'],
          userPoints: body['user']['punctuation'],
          userDoneTasks: body['user']['finished_tasks'],
          token: token,
          // isDarkMode: body['isDarkMode'],
        );
        if (user.imagePath == null) {
          final userPrefer = UserPreferences.myUser;
          user.imagePath = userPrefer.imagePath;
        }
        return user;
      } else {
        throw Exception('Failed to parse user data');
      }
    } else {
      debugPrint('StatusCode != 200');
      //   throw Exception(
      //       'Failed to create login. Status code: ${response.statusCode}');

      //   // return (user);
    }
  }
}
