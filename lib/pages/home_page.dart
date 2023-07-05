import 'package:flutter/material.dart';
import 'package:reptask/components/drawer/drawer_content_component.dart';
import 'package:reptask/components/task/create_task_modal.dart';
import 'package:reptask/components/task/task_list.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/widget/appbar_widget.dart';
import '../components/bottom_modal.dart';
import '../components/task/filter_task_component.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.title, required this.user, required this.token})
      : super(key: key);
  final UserModel user;
  final String title;
  final String token;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    drawerActivePage = 'home';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.title, true, widget.user),
      drawer: const Drawer(
        child: DrawerContent(),
      ),
      body: Column(
        children: <Widget>[
          const FilterTasks(),
          Expanded(
            child: ListViewHomeLayout(
                displayContent: widget.user.userType == 0 ? true : false,
                userId: widget.user.id!,
                token: widget.token),
          ),
        ],
      ),
      floatingActionButton: widget.user.userType == 1
          ? FloatingActionButton(
              onPressed: () => showModal(context, const CreateTaskModal()),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
// body: Center(
//         child: Column(
//           children: [
//             const FilterTasks(),
//           ],
//         ),