import 'package:flutter/material.dart';
import 'package:reptask/components/bottom_modal.dart';
import 'package:reptask/components/drawer/drawer_content_component.dart';
import 'package:reptask/components/user/create_user_modal.dart';

import '../utils/user_preferences.dart';
import '../widget/appbar_widget.dart';

class MyRepPage extends StatefulWidget {
  const MyRepPage({Key? key}) : super(key: key);

  @override
  State<MyRepPage> createState() => _MyRepPageState();
}

class _MyRepPageState extends State<MyRepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'República', true),
      drawer: const Drawer(
        child: DrawerContent(),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(context, const CreateUserModal());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
