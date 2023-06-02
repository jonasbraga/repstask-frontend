import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:reptask/models/comments_model.dart';

import '../configs/config.dart';

class CommentsController {
  Future registerComment(Comment comment) async {
    final Uri uri = Uri.parse('http://$backendAdress/comments');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var data = {
      'task_id': comment.taskId,
      'user_id': comment.userId,
      'comment': comment.comment
    };

    var body = jsonEncode(data);

    await http.post(uri, headers: headers, body: body);
  }
}
