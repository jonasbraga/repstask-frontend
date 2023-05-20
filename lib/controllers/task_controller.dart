import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reptask/configs/config.dart';
import 'package:reptask/models/task_model.dart';

class TaskController {
  Future createTask(TaskModel newTask) async {
    final Uri uri = Uri.parse('http://$backendAdress/tasks');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var data = {
      'title': newTask.titulo,
      'description': newTask.descricao,
      'deadline': DateFormat('yyyy-MM-dd').format(newTask.prazo),
      'score': {
        'responsible_user': int.parse(newTask.responsavel),
        'value': newTask.pontos,
        'finished': false
      }
    };
    var body = json.encode(data);

    final response = await http.post(uri, headers: headers, body: body);
  }
}
