import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reptask/configs/config.dart';
import 'package:reptask/controllers/streams_controller.dart';
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
    refreshTaskPageStream.sink.add(null);
  }

  Future<List<TaskModel>> getTasks() async {
    final response =
        await http.get(Uri.parse('http://$backendAdress/tasks-all/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var body = jsonDecode(response.body);
      List<TaskModel> results = [];
      body.forEach((taskJson) {
        TaskModel task = TaskModel(
            pontos: taskJson['value'],
            prazo: DateTime.parse(taskJson['deadline']),
            responsavel: taskJson['responsible_user'].toString(),
            titulo: taskJson['title'],
            descricao: taskJson['description'],
            id: taskJson['id']);
        results.add(task);
      });
      return results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
