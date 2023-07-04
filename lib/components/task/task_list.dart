import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reptask/components/task/create_task_modal.dart';
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/controllers/task_controller.dart';
import 'package:reptask/models/task_model.dart';
import 'package:reptask/models/trask_filters_model.dart';
import '../bottom_modal.dart';
import 'task_details_component.dart';

class ListViewHomeLayout extends StatefulWidget {
  const ListViewHomeLayout(
      {super.key,
      required this.displayContent,
      required this.userId,
      required this.token});
  final bool displayContent;
  final int userId;
  final String token;

  @override
  State<ListViewHomeLayout> createState() => _ListViewHome();
}

class _ListViewHome extends State<ListViewHomeLayout> {
  TaskController taksController = TaskController();
  List<TaskModel> taksList = [];
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = refreshTaskPageStream.stream.listen((event) {
      refreshPage();
    });
    taksController
        .getTasks(taskFilterActive, widget.userId, widget.token)
        .then((taskResults) => setState(() => taksList = taskResults));
  }

    @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
                  onTap: () {
                    showModal(
                      context,
                      CreateCommentsModal(taskData: taksList[index]),
                    );
                  },
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
                              CreateCommentsModal(taskData: taksList[index]),
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
        .getTasks(taskFilterActive, widget.userId, widget.token)
        .then((taskResults) => setState(() => taksList = taskResults));
  }
}
