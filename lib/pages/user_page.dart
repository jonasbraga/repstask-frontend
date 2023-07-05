import 'package:flutter/material.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/widget/appbar_widget.dart';
import '../components/bottom_modal.dart';
import '../components/user/create_user_modal.dart';
import '../components/user/user_list.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.title, required this.user})
      : super(key: key);
  final UserModel user;
  final String title;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, widget.title, true, widget.user),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListViewUserLayout(
                displayContent: widget.user.userType == 0 ? true : false,
                user: widget.user,
                token: widget.user.token),
          ),
        ],
      ),
      floatingActionButton: widget.user.userType == 1
          ? FloatingActionButton(
              onPressed: () => showModal(context, const CreateUserModal()),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
