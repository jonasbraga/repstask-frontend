import 'package:flutter/material.dart';
import 'package:reptask/controllers/comments_controller.dart';
import 'package:reptask/models/comments_model.dart';

class CreateCommentComponent extends StatefulWidget {
  const CreateCommentComponent({super.key, required this.taskId});
  final int taskId;

  @override
  State<CreateCommentComponent> createState() => _CreateCommentComponentState();
}

class _CreateCommentComponentState extends State<CreateCommentComponent> {
  final TextEditingController _commentController = TextEditingController();
  final CommentsController _commentsController = CommentsController();

  @override
  void initState() {
    super.initState();
    _commentController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 24, bottom: 24),
          child: TextFormField(
            minLines: 1,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _commentController,
            decoration: const InputDecoration(
                labelText: 'Comentário',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 20,
              margin: const EdgeInsets.only(bottom: 36),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 1.25, fontSize: 16),
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 20,
              margin: const EdgeInsets.only(bottom: 36),
              child: TextButton(
                  onPressed: () {
                    if (_commentController.text.trim().isNotEmpty) {
                      createComment(
                          _commentController.text.trim(), widget.taskId);
                      Navigator.pop(context);
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Comentar',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 1.25, fontSize: 16),
                  )),
            )
          ],
        )
      ],
    );
  }

  createComment(String commentTyped, int taskId) {
    Comment comment = Comment(comment: commentTyped, taskId: taskId, userId: 1);
    _commentsController.registerComment(comment);
  }
}
