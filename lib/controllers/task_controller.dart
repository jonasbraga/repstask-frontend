import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reptask/configs/config.dart';
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/models/task_model.dart';
import 'package:reptask/models/trask_filters_model.dart';

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
    refreshTaskPageStream.sink.add(taskFilterActive);
  }

  Future updateTask(TaskModel newTask) async {
    var id = newTask.id.toString();
    final Uri uri = Uri.parse('http://$backendAdress/tasks/$id');
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

    await http.patch(uri, headers: headers, body: body);
    refreshTaskPageStream.sink.add(taskFilterActive);
  }

  Future deleteTask(int id) async {
    final Uri uri = Uri.parse('http://$backendAdress/tasks/$id');
    await http.delete(uri);
    refreshTaskPageStream.sink.add(taskFilterActive);
  }

  Future finishTask(TaskModel taskToFinish) async {
    var id = taskToFinish.id.toString();
    final Uri uri = Uri.parse('http://$backendAdress/tasks/$id');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var data = {
      'title': taskToFinish.titulo,
      'description': taskToFinish.descricao,
      'deadline': DateFormat('yyyy-MM-dd').format(taskToFinish.prazo),
      'score': {
        'responsible_user': int.parse(taskToFinish.responsavel),
        'value': taskToFinish.pontos,
        'finished': true
      }
    };
    var body = json.encode(data);

    final response = await http.patch(uri, headers: headers, body: body);
    refreshTaskPageStream.sink.add(taskFilterActive);
  }

  Future<List<TaskModel>> getTasks(TaskFilterModel filters) async {
    var filterOption = 2;

    if (filters.showPendentsTasks || filters.showFinishedTasks) {
      filterOption = filters.showPendentsTasks ? 0 : 1;
    }

    var userIdIfFiltered = filters.onlyMyTasks ? '/1' : '';

    final response = await http.get(Uri.parse(
        'http://$backendAdress/tasks/$filterOption$userIdIfFiltered'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var body = jsonDecode(response.body);
      List<TaskModel> results = [];
      if (body.length > 0) {
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
      }
      return results;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
