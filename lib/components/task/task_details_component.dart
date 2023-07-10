import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reptask/components/bottom_modal.dart';
import 'package:reptask/components/comment/create_comment_component.dart';
import 'package:reptask/controllers/comments_controller.dart';
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/controllers/task_controller.dart';
import 'package:reptask/models/comments_model.dart';
import 'package:reptask/models/task_model.dart';

import '../../utils/user_preferences.dart';

class CreateCommentsModal extends StatefulWidget {
  const CreateCommentsModal({super.key, required this.taskData});
  final TaskModel taskData;

  @override
  State<CreateCommentsModal> createState() => _CreateCommentsModalState();
}

class _CreateCommentsModalState extends State<CreateCommentsModal> {
  // late Task responsaveis;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskPointsController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final CommentsController _commentsController = CommentsController();
  late TaskModel taskData;
  List<Comment> commentsList = [];
  late StreamSubscription subscription;

  // get index => null;
  //Alterar o get de responsáveis

  @override
  void initState() {
    super.initState();
    subscription = refreshTaskDetailsStream.stream.listen((event) {
      refreshDetails();
    });
    taskData = widget.taskData;
    _commentsController
        .getComments(taskData.id ?? 0)
        .then((commnetsResult) => setState(
              () => commentsList = commnetsResult,
            ));
    _taskTitleController.text = taskData.titulo;
    _taskPointsController.text = taskData.pontos.toString();
    _taskDescriptionController.text = taskData.descricao ?? '';
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Widget buildImage(image) {
    final bytes =
        base64.decode(image != '' ? image : UserPreferences.imageUserDefaut);
    final imageProvider = MemoryImage(bytes);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageProvider,
          fit: BoxFit.cover,
          width: 32,
          height: 32,
        ),
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Icon(
            Icons.expand_more,
            color: Color.fromRGBO(0, 0, 0, 0.70),
            size: 48,
          ),
        ),
        SizedBox(
          height: 24,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              widget.taskData.titulo,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.15,
                  color: Color.fromRGBO(0, 0, 0, 0.7)),
            ),
            buildImage(widget.taskData.responsavelPhoto ?? ''),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(taskData.pontos.toString()),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 9, bottom: 50),
          child: Column(
            children: [
              TextField(
                readOnly: true,
                controller: _taskDescriptionController,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                ),
                decoration: const InputDecoration(
                    fillColor: Color.fromARGB(255, 197, 194, 194),
                    filled: true,
                    border: InputBorder.none),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Comentários",
                style: TextStyle(
                    letterSpacing: 0.15,
                    fontSize: 24,
                    color: Color.fromRGBO(0, 0, 0, 1))),
            IconButton(
                onPressed: () {
                  showModal(
                      context, CreateCommentComponent(taskId: taskData.id ?? 0),
                      backgroungTransparent: false);
                },
                icon: const Icon(
                  Icons.add,
                  size: 24,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ))
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading:
                            buildImage(commentsList[index].userPhoto ?? ''),
                        title: Text(commentsList[index].userNick),
                        subtitle: Text(commentsList[index].comment),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        if (UserPreferences.myUser.userType == 1 ||
            UserPreferences.myUser.id == widget.taskData.responsavelId)
          Container(
            width: 154,
            height: 36,
            margin: const EdgeInsets.only(top: 32, bottom: 78),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  finishTask();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'FINALIZAR',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.25,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
          )
      ],
    );
  }

  void finishTask() async {
    await TaskController().finishTask(taskData);
  }

  void refreshDetails() async {
    _commentsController
        .getComments(taskData.id ?? 0)
        .then((commentsResults) => setState(
              () => commentsList = commentsResults,
            ));
  }
}
