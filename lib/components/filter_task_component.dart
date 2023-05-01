import 'package:flutter/material.dart';
import 'package:reptask/utils/primary_color.dart';

class FilterTasks extends StatefulWidget {
  const FilterTasks({Key? key}) : super(key: key);

  @override
  State<FilterTasks> createState() => _FilterTasks();
}

class _FilterTasks extends State<FilterTasks> {
  bool _hasFavoriteBeenPressed = false;
  bool _hasPendentsBeenPressed = false;
  bool isSwitched = false;

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
                backgroundColor: _hasFavoriteBeenPressed
                    ? const MaterialStatePropertyAll(
                        Color.fromRGBO(217, 217, 217, 1),
                      )
                    : MaterialStatePropertyAll(
                        primaryColor,
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
                    _hasFavoriteBeenPressed = !_hasFavoriteBeenPressed;
                  },
                ),
              },
              child: _hasFavoriteBeenPressed
                  ? (const Text('FINALIZADOS',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)))
                  : (const Text('FINALIZADOS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
            ),
            const Spacer(flex: 1),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: _hasPendentsBeenPressed
                    ? const MaterialStatePropertyAll(
                        Color.fromRGBO(217, 217, 217, 1),
                      )
                    : MaterialStatePropertyAll(
                        primaryColor,
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
                  },
                ),
              },
              child: _hasPendentsBeenPressed
                  ? (const Text('PENDENTES',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      )))
                  : (const Text('PENDENTES',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
            ),
            const Spacer(flex: 7),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
