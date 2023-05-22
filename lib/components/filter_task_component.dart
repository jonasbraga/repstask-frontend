import 'package:flutter/material.dart';
import 'package:reptask/utils/primary_color.dart';

import '../controllers/streams_controller.dart';

class FilterTasks extends StatefulWidget {
  const FilterTasks({Key? key}) : super(key: key);

  @override
  State<FilterTasks> createState() => _FilterTasks();
}

class _FilterTasks extends State<FilterTasks> {
  bool _hasFinalizadoBeenPressed = false;
  bool _hasPendentsBeenPressed = true;
  bool _hasSelfTasks = false;

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
                backgroundColor: _hasFinalizadoBeenPressed
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
                    _hasFinalizadoBeenPressed = !_hasFinalizadoBeenPressed;
                    if (_hasFinalizadoBeenPressed == _hasPendentsBeenPressed) {
                      _hasPendentsBeenPressed = false;
                    }
                    notifyTaskList();
                  },
                ),
              },
              child: _hasFinalizadoBeenPressed
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
                backgroundColor: _hasPendentsBeenPressed
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
                    _hasPendentsBeenPressed = !_hasPendentsBeenPressed;

                    if (_hasFinalizadoBeenPressed == _hasPendentsBeenPressed) {
                      _hasFinalizadoBeenPressed = false;
                    }
                    notifyTaskList();
                  },
                ),
              },
              child: _hasPendentsBeenPressed
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
              value: _hasSelfTasks,
              onChanged: (value) {
                setState(() {
                  _hasSelfTasks = value;
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
    refreshTaskPageStream.sink.add(
        [_hasFinalizadoBeenPressed, _hasPendentsBeenPressed, _hasSelfTasks]);
  }
}
