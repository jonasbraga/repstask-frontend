import 'package:flutter/material.dart';
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/models/user_model.dart';
import '../../controllers/user_controller.dart';

class ListViewUserLayout extends StatefulWidget {
  const ListViewUserLayout(
      {super.key,
      required this.displayContent,
      required this.user,
      required this.token});
  final bool displayContent;
  final UserModel user;
  final String token;

  @override
  State<ListViewUserLayout> createState() => _ListViewHome();
}

class _ListViewHome extends State<ListViewUserLayout> {
  UserController usersController = UserController();
  List<UserModel> userList = [];

  @override
  void initState() {
    super.initState();
    refreshUserPageStream.stream.listen((event) {
      refreshPage();
    });
    usersController
        .getUsersList(widget.user, widget.token)
        .then((UsersResults) => setState(() => userList = UsersResults));
  }

  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshPage,
      child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Card(
                key: ValueKey(index),
                child: ListTile(
                  // onTap: () {
                  //   showModal(
                  //     context,
                  //     CreateCommentsModal(taskData: userList[index]),
                  //   );
                  // },
                  leading: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      CircleAvatar(),
                    ],
                  ),
                  title: Text(userList[index].name),
                  subtitle: Text(userList[index].nickname.toString()),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      // Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Texto 1',
                      //         style: TextStyle(fontSize: 20),
                      //       ),
                      //     ]),
                      // Text(userList[index].userType.toString()),
                      if (!widget.displayContent)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Excluir usuário'),
                                  content: const Text(
                                      'Tem certeza que deseja excluir usuário?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Excluir'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        UserController().deleteTask(
                                            userList[index].id ?? 0);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                    ],
                  ),
                ));
          }),
    );
  }

  Future<void> refreshPage() async {
    usersController
        .getUsersList(widget.user, widget.token)
        .then((UsersResults) => setState(() => userList = UsersResults));
  }
}
