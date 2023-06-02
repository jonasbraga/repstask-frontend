import 'package:flutter/material.dart';

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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}