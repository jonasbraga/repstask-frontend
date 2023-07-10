import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/configs/config.dart';
import 'package:reptask/models/cadastro_model.dart';

import '../utils/user_preferences.dart';

class CadastroController {
  Future createLogin(CadastroModel newCadastro) async {
    final Uri uri = Uri.parse('http://$backendAdress/cadastro');
    final token = UserPreferences.myUser.token;
    final headers = {
      'Authorization': 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var data = {
      'rep': newCadastro.rep,
      'user': newCadastro.usuario,
      'email': newCadastro.email,
      'password': newCadastro.senha,
    };
    var body = json.encode(data);

    final response = await http.get(uri, headers: headers);
  }
}
