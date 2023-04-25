import 'package:flutter/material.dart';
import 'package:reptask/components/create_task_modal.dart';
import '../components/bottom_modal.dart';

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
      body: Center(
        child: Column(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(context, const CreateTaskModal()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
