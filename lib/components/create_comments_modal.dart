import 'package:flutter/material.dart';
import 'package:reptask/controllers/task_controller.dart';
import '../models/comments_model.dart';

class CreateCommentsModal extends StatefulWidget {
  const CreateCommentsModal({super.key, this.disabledData});
  final Comments? disabledData;

  @override
  State<CreateCommentsModal> createState() => _CreateCommentsModalState();
}

class _CreateCommentsModalState extends State<CreateCommentsModal> {
  // late Task responsaveis;
  late String taskTitle;
  late int taskPoints;
  late String taskDescription;
  late String responsavelSelected;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskPointsController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
 //Alterar o get de responsáveis

  @override
  void initState() {
    super.initState();
    taskTitle = widget.disabledData?.titulo ?? '';
    _taskTitleController.text = taskTitle;
    taskPoints = widget.disabledData?.pontos ?? 0;
    _taskPointsController.text = taskPoints.toString();
    taskDescription = widget.disabledData?.descricao ?? '';
    _taskDescriptionController.text = taskDescription;
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

        Container(
          height: 24,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(taskTitle,
            style: TextStyle(
              fontSize: 24, 
              fontWeight:FontWeight.w400, 
              letterSpacing: 0.15,
              color: Color.fromRGBO(0, 0, 0, 0.7)
            ),),
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
              'https://source.unsplash.com/50x50/?portrait',
              ),
            ),
          ]),
        ),
        Row( mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(taskPoints.toString()),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 9, bottom: 50),
          child: Column(
            children: [
              TextField(controller: _taskDescriptionController,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
              ),
            )],
          ),
        ),
        Container(
          width: 154,
          height: 36,
          margin: const EdgeInsets.only(top: 236, bottom: 78),
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                      'FINALIZAR',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
        )],
    );
  }
}
