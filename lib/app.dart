import 'package:flutter/material.dart';
import 'package:reptask/pages/login_page.dart';
import 'package:reptask/utils/primary_color.dart';
import 'pages/home_page.dart';
import 'pages/cadastro_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      // home: const MyHomePage(title: 'Tarefas'),
      // home: const CadastroPage(),
      home: const LoginPage(),
    );
  }
}
