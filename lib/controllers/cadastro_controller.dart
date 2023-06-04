import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/configs/config.dart';
import 'package:reptask/models/cadastro_model.dart';

class LoginController {
  Future createLogin(CadastroModel newCadastro) async {
    final Uri uri = Uri.parse('http://$backendAdress/cadastro');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

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