import 'package:flutter/material.dart';
import 'package:reptask/models/trask_filters_model.dart';
import 'package:reptask/utils/primary_color.dart';

import '../controllers/streams_controller.dart';

class FilterTasks extends StatefulWidget {
  const FilterTasks({Key? key}) : super(key: key);

  @override
  State<FilterTasks> createState() => _FilterTasks();
}

class _FilterTasks extends State<FilterTasks> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0),
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            const Spacer(flex: 1),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: taskFilterActive.showFinishedTasks
                    ? MaterialStatePropertyAll(
                        primaryColor,
                      )
                    : const MaterialStatePropertyAll(
                        Color.fromRGBO(217, 217, 217, 1),
                      ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // raio das bordas
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(10, 22), // largura e altura mínimas
                ),
              ),
              onPressed: () => {
                setState(
                  () {
                    // Pendente ta selecionado? se sim, desmarca o pendente também.
                    taskFilterActive.showFinishedTasks =
                        !taskFilterActive.showFinishedTasks;
                    if (taskFilterActive.showFinishedTasks ==
                        taskFilterActive.showPendentsTasks) {
                      taskFilterActive.showPendentsTasks = false;
                    }
                    notifyTaskList();
                  },
                ),
              },
              child: taskFilterActive.showFinishedTasks
                  ? (const Text('FINALIZADOS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)))
                  : (const Text('FINALIZADOS',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
            ),
            const Spacer(flex: 1),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: taskFilterActive.showPendentsTasks
                    ? MaterialStatePropertyAll(
                        primaryColor,
                      )
                    : const MaterialStatePropertyAll(
                        Color.fromRGBO(217, 217, 217, 1),
                      ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // raio das bordas
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(10, 22), // largura e altura mínimas
                ),
              ),
              onPressed: () => {
                setState(
                  () {
                    taskFilterActive.showPendentsTasks =
                        !taskFilterActive.showPendentsTasks;

                    if (taskFilterActive.showFinishedTasks ==
                        taskFilterActive.showPendentsTasks) {
                      taskFilterActive.showFinishedTasks = false;
                    }
                    notifyTaskList();
                  },
                ),
              },
              child: taskFilterActive.showPendentsTasks
                  ? (const Text('PENDENTES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      )))
                  : (const Text('PENDENTES',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
            ),
            const Spacer(flex: 7),
            Switch(
              value: taskFilterActive.onlyMyTasks,
              onChanged: (value) {
                setState(() {
                  taskFilterActive.onlyMyTasks = value;
                  notifyTaskList();
                });
              },
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void notifyTaskList() {
    refreshTaskPageStream.sink.add(taskFilterActive);
  }
}
