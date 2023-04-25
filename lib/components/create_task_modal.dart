import 'package:flutter/material.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({Key? key}) : super(key: key);

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  String taskTitle = '';
  int taskPoints = 0;
  String? taskDescription = '';
  String responsavelSelected = "1";
  List<DropdownMenuItem<String>> responsaveis = [
    const DropdownMenuItem(value: "1", child: Text("Barbosa")),
    const DropdownMenuItem(value: "2", child: Text("João Pedro"))
  ]; //Alterar o get de responsáveis

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
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'CRIAR',
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1.25, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
