import 'package:flutter/material.dart';
import 'package:reptask/components/create_task_modal.dart';
import 'package:reptask/utils/primary_color.dart';
import '../components/bottom_modal.dart';
import '../components/filter_task_component.dart';
import '../components/task_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: const <Widget>[
          FilterTasks(),
          Expanded(
            child: ListViewHomeLayout(displayContent: false),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(context, const CreateTaskModal()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
// body: Center(
//         child: Column(
//           children: [
//             const FilterTasks(),
//           ],
//         ),