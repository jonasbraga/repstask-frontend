import 'package:flutter/material.dart';
import 'package:reptask/components/bottom_modal.dart';
import 'package:reptask/components/task/create_comment_component.dart';
import 'package:reptask/controllers/task_controller.dart';
import 'package:reptask/models/task_model.dart';

class CreateCommentsModal extends StatefulWidget {
  const CreateCommentsModal({super.key, required this.taskData});
  final TaskModel taskData;

  @override
  State<CreateCommentsModal> createState() => _CreateCommentsModalState();
}

class _CreateCommentsModalState extends State<CreateCommentsModal> {
  // late Task responsaveis;
  late TaskModel taskData;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskPointsController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  //Alterar o get de responsáveis

  @override
  void initState() {
    super.initState();
    taskData = widget.taskData;
    _taskTitleController.text = taskData.titulo;
    _taskPointsController.text = taskData.pontos.toString();
    _taskDescriptionController.text = taskData.descricao ?? '';
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
            const CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/50x50/?portrait',
              ),
            ),
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
                  showModal(context, const CreateCommentComponent(),
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
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                              'https://source.unsplash.com/50x50/?portrait'),
                        ),
                        title: Text('Vinicius'),
                        subtitle: Text(
                            'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
}
