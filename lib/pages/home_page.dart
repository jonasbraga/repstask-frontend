import 'package:flutter/material.dart';
import 'package:reptask/components/task/create_task_modal.dart';
import 'package:reptask/components/task/task_list.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/widget/appbar_widget.dart';
import '../components/bottom_modal.dart';
import '../components/task/filter_task_component.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.user})
      : super(key: key);
  final UserModel user;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.title, true, widget.user),
      body: Column(
        children: <Widget>[
          const FilterTasks(),
          Expanded(
            child: ListViewHomeLayout(
                displayContent: false,
                userId: widget.user.id!,
                token: widget.user.token!),
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