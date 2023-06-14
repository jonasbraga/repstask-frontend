import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reptask/configs/config.dart';
import 'package:reptask/models/login_model.dart';

class LoginController {
  Future createLogin(LoginModel newLogin) async {
    final Uri uri = Uri.parse('http://$backendAdress/login');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var data = {
      'rep': newLogin.rep,
      'user': newLogin.usuario,
      'password': newLogin.senha,
    };
    var body = json.encode(data);

    final response = await http.post(uri, headers: headers, body: body);
  }
}