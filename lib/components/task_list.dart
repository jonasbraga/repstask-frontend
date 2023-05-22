import 'package:flutter/material.dart';
import 'package:reptask/components/create_task_modal.dart';
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/controllers/task_controller.dart';
import 'package:reptask/models/task_model.dart';
import '../components/bottom_modal.dart';
import '../models/comments_model.dart';
import 'create_comments_modal.dart';

class ListViewHomeLayout extends StatefulWidget {
  const ListViewHomeLayout({super.key, required this.displayContent});
  final bool displayContent;

  @override
  State<ListViewHomeLayout> createState() => _ListViewHome();
}

class _ListViewHome extends State<ListViewHomeLayout> {
  TaskController taksController = TaskController();
  List<TaskModel> taksList = [];

  @override
  void initState() {
    super.initState();
    refreshTaskPageStream.stream.listen((event) {
      refreshPage();
    });
    taksController
        .getTasks()
        .then((taskResults) => setState(() => taksList = taskResults));
  }

  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshPage,
      child: ListView.builder(
          itemCount: taksList.length,
          itemBuilder: (context, index) {
            return Card(
                key: ValueKey(index),
                child: ListTile(
                  title: Text(taksList[index].titulo),
                  subtitle: Text(taksList[index].pontos.toString()),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      if (widget.displayContent) const CircleAvatar(),
                      if (widget.displayContent)
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: () {
                            showModal(
                              context,
                              CreateCommentsModal(
                                  disabledData: Comments(
                                id: taksList[index].id,
                                titulo: taksList[index].titulo,
                                pontos: 2,
                                descricao: taksList[index].descricao,
                              )),
                            );
                          },
                        )
                      else
                        StatefulBuilder(
                          builder: (context, setState) {
                            return PopupMenuButton<String>(
                              onSelected: (value) {
                                // Handle menu item selection here
                                switch (value) {
                                  case "option1":
                                    showModal(
                                        context,
                                        Column(children: [
                                          CreateTaskModal(
                                              taskDataSended: taksList[index]),
                                        ]));
                                    ;
                                    break;
                                  case "option2":
                                    TaskController()
                                        .deleteTask(taksList[index].id ?? 0);

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
                            );
                          },
                        ),
                    ],
                  ),
                ));
          }),
    );
  }

  Future<void> refreshPage() async {
    taksController
        .getTasks()
        .then((taskResults) => setState(() => taksList = taskResults));
  }
}
