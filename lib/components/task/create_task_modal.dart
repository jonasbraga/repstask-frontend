import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reptask/controllers/task_controller.dart';
import 'package:reptask/controllers/user_controller.dart';
import 'package:reptask/models/task_model.dart';
import 'package:reptask/models/user_model.dart';

import '../../utils/user_preferences.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key, this.taskDataSended});
  final TaskModel? taskDataSended;

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  UserController userController = UserController();
  late TaskModel taskData;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskPointsController = TextEditingController();
  final TextEditingController _taskDeadlineController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  List<UserModel> userList = [UserPreferences.myUser];

  @override
  void initState() {
    super.initState();
    taskData = widget.taskDataSended ??
        TaskModel(
            titulo: '',
            pontos: 0,
            responsavel: '1',
            prazo: DateTime.now(),
            descricao: '');
    _taskTitleController.text = taskData.titulo;
    _taskPointsController.text = taskData.pontos.toString();
    _taskDeadlineController.text =
        DateFormat('dd/MM/yyyy').format(taskData.prazo);
    _taskDescriptionController.text = taskData.descricao ?? '';

    userController
        .getUsersList(UserPreferences.myUser, UserPreferences.myUser.token)
        .then((usersresults) => {
              debugPrint(usersresults.length.toString()),
              setState(() => userList = usersresults)
            });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 18),
          child: const Icon(
            Icons.expand_more,
            color: Color.fromRGBO(0, 0, 0, 0.70),
            size: 48,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: _taskTitleController,
            onChanged: (value) => setState(() {
              taskData.titulo = value;
            }),
            decoration: const InputDecoration(
                labelText: 'Título',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _taskPointsController,
            onChanged: (value) => setState(() {
              if (!(int.tryParse(value) == null)) {
                taskData.pontos = int.parse(value);
              }
            }),
            decoration: const InputDecoration(
                labelText: 'Pontos',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            controller: _taskDeadlineController,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                setState(() {
                  _taskDeadlineController.text = formattedDate;
                  taskData.prazo = pickedDate;
                });
              } else {}
            },
            decoration: const InputDecoration(
                labelText: 'Prazo',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: DropdownButtonFormField(
            value: userList[0].id.toString(),
            items: userList.map((responsavel) {
              return DropdownMenuItem(
                value: responsavel.id.toString(),
                child: Text(responsavel.name),
              );
            }).toList(),
            decoration: const InputDecoration(
                labelText: 'Responsável',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
            onChanged: (String? newValue) {
              setState(() {
                taskData.responsavel = newValue!;
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 36),
          child: TextFormField(
            minLines: 3,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _taskDescriptionController,
            onChanged: (value) => setState(() {
              taskData.descricao = value;
            }),
            decoration: const InputDecoration(
                labelText: 'Descrição',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 20,
          margin: const EdgeInsets.only(bottom: 36),
          child: TextButton(
              onPressed: () {
                widget.taskDataSended != null ? updateTask() : criarTask();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: widget.taskDataSended != null
                  ? const Text(
                      'ATUALIZAR',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontSize: 16),
                    )
                  : const Text(
                      'CRIAR',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontSize: 16),
                    )),
        )
      ],
    );
  }

  criarTask() {
    TaskController().createTask(taskData);
  }

  updateTask() {
    TaskController().updateTask(taskData);
  }
}
