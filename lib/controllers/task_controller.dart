import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/configs/config.dart';
import 'package:reptask/models/task_model.dart';

class TaskController {
  Future createTask(TaskModel newTask) async {
    final Uri uri = Uri.parse('http://$backendAdress/tasks');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var body = {
      'title': newTask.titulo,
      'description': newTask.descricao,
      'deadline': newTask.prazo,
      'score': {
        'responsible_user': newTask.responsavel,
        'value': newTask.pontos,
        'finished': false
      }
    };

    final response = await http.post(uri, headers: headers, body: body);
  }
}
