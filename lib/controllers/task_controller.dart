import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/models/task_model.dart';

class TaskController {
  Future createTask({titulo, pontos, descricao, responsavel}) async {
    final Uri uri = Uri.parse('http://localhost/task');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var body =
        TaskModel(titulo: titulo, pontos: pontos, responsavel: responsavel)
            .toJson();

    await http.post(uri, headers: headers, body: '$body');
  }
}
