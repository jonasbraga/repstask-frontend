import 'package:flutter/material.dart';
import 'package:reptask/controllers/task_controller.dart';
import 'package:reptask/models/task_model.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key, this.editData});
  final TaskModel? editData;

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  // late Task responsaveis;
  late String taskTitle;
  late int taskPoints;
  late String taskDescription;
  late String responsavelSelected;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskPointsController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  List<DropdownMenuItem<String>> responsaveis = [
    const DropdownMenuItem(value: "1", child: Text("Barbosa")),
    const DropdownMenuItem(value: "2", child: Text("João Pedro"))
  ]; //Alterar o get de responsáveis

  @override
  void initState() {
    super.initState();
    taskTitle = widget.editData?.titulo ?? '';
    _taskTitleController.text = taskTitle;
    taskPoints = widget.editData?.pontos ?? 0;
    _taskPointsController.text = taskPoints.toString();
    taskDescription = widget.editData?.descricao ?? '';
    _taskDescriptionController.text = taskDescription;
    responsavelSelected = widget.editData?.responsavel ?? '1';
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
              taskTitle = value;
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
                taskPoints = int.parse(value);
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
          child: DropdownButtonFormField(
            value: responsavelSelected,
            items: responsaveis,
            decoration: const InputDecoration(
                labelText: 'Responsável',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
            onChanged: (String? newValue) {
              setState(() {
                responsavelSelected = newValue!;
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
              taskDescription = value;
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
                widget.editData != null ? updateTask() : criarTask();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: widget.editData != null
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
    TaskController().createTask(TaskModel(
        titulo: taskTitle,
        pontos: taskPoints,
        descricao: taskDescription,
        prazo: DateTime.now(), // Arrumar o prazo para uma variavel
        responsavel: responsavelSelected));
  }

  updateTask() {}
}
