import 'package:flutter/material.dart';
import 'package:reptask/components/bottom_modal.dart';
import 'package:reptask/components/create_user_modal.dart';

class MyRepPage extends StatefulWidget {
  const MyRepPage({Key? key}) : super(key: key);

  @override
  State<MyRepPage> createState() => _MyRepPageState();
}

class _MyRepPageState extends State<MyRepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('República'),
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