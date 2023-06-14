import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/components/create_task_modal.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/pages/profile_page.dart';
import 'package:reptask/widget/appbar_widget.dart';
import 'package:reptask/widget/menu_wigget.dart';
import '../components/bottom_modal.dart';
import '../components/filter_task_component.dart';
import '../components/task_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;
  final UserModel user;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          // appBar: buildAppBar(context, widget.title, widget.idUser, true),
          appBar: AppBar(
              title: const Text('Terefas'),
              leading: const MenuButton(),
              // backgroundColor: ,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      const Text('Pontos'),
                      const SizedBox(
                        height: 2,
                      ),
                      buildImage(widget.user),
                    ],
                  ),
                )
              ]),

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
        ),
      ),
    );
  }

  Widget buildImage(UserModel user) {
    final bytes = base64.decode(user.imagePath!);
    final imageProvider = MemoryImage(bytes);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageProvider,
          fit: BoxFit.cover,
          width: 32,
          height: 32,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ProfilePage(title: 'Perfil')),
              );
            },
          ),
        ),
      ),
    );
    //
  }
}
// body: Center(
//         child: Column(
//           children: [
//             const FilterTasks(),
//           ],
//         ),