import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/models/comments_model.dart';

import '../configs/config.dart';
import '../utils/user_preferences.dart';

class CommentsController {
  Future registerComment(Comment comment) async {
    final Uri uri = Uri.parse('http://$backendAdress/comments');
    final token = UserPreferences.myUser.token;
    final headers = {
      'Authorization': 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var data = {
      'task_id': comment.taskId,
      'user_id': comment.userId,
      'comment': comment.comment
    };

    var body = jsonEncode(data);

    await http.post(uri, headers: headers, body: body);
    refreshTaskDetailsStream.sink.add(null);
  }

  Future<List<Comment>> getComments(int taskId) async {
    final Uri uri = Uri.parse('http://$backendAdress/comments/$taskId');
    final token = UserPreferences.myUser.token;
    final headers = {
      'Authorization': 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response = await http.get(uri, headers: headers);

    List<Comment> results = [];
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body.length > 0) {
        body.forEach((commentJson) {
          Comment comment = Comment(
            comment: commentJson['comment'],
            taskId: commentJson['task_id'],
            userId: commentJson['user_id'],
            userNick: commentJson['nickname'],
            userPhoto: commentJson['photo'],
          );
          results.add(comment);
        });
      }
    }

    return results;
  }
}
