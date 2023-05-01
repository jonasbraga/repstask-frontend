import 'package:flutter/material.dart';
import 'package:reptask/components/create_task_modal.dart';
import '../components/bottom_modal.dart';

class ListViewHomeLayout extends StatefulWidget {
  const ListViewHomeLayout({super.key, required this.displayContent});
  final bool displayContent;

  @override
  State<ListViewHomeLayout> createState() => _ListViewHome();
}

class _ListViewHome extends State<ListViewHomeLayout> {
  List<String> titles = [
    "List 1",
    "List 2",
    "List 3",
    "List 4",
    "List 5",
    "List 6",
    "List 7",
    "List 8",
    "List 9",
  ];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle",
    "Here is list 4 subtitle",
    "Here is list 5 subtitle",
    "Here is list 6 subtitle",
    "Here is list 7 subtitle",
    "Here is list 8 subtitle",
    "Here is list 9 subtitle"
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
              key: ValueKey(index),
              child: ListTile(
                title: Text(titles[index]),
                subtitle: Text(subtitles[index]),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    if (widget.displayContent) const CircleAvatar(),
                    if (widget.displayContent)
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {},
                      )
                    else
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          // Handle menu item selection here
                          switch (value) {
                            case "option1":
                              showModal(
                                  context,
                                  CreateTaskModal(
                                    editData: Task(
                                        id: index,
                                        titulo: titles[index],
                                        pontos: 2,
                                        responsavel: '2',
                                        descricao: subtitles[index]),
                                  ));
                              break;
                            case "option2":
                              print("Option 1 selected");
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: "option1",
                            child: ListTile(
                              title: Text('Editar'),
                              trailing: Icon(Icons.create_rounded),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: "option2",
                            child: ListTile(
                                title: Text('Excluir'),
                                trailing: Icon(Icons.delete)),
                          ),
                        ],
                      ),
                  ],
                ),
              ));
        });
  }
}
