import 'package:flutter/material.dart';
import 'package:reptask/controllers/user_controller.dart';

import '../models/user_model.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key, this.userInfo});
  final UserModel? userInfo;
  @override
  State<EditPassword> createState() => _EditPassword();
}

class _EditPassword extends State<EditPassword> {
  final TextEditingController _userPasswordController = TextEditingController();
  late UserModel userResult;

  UserController userController = UserController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 12),
      TextField(
        controller: _userPasswordController,
        onChanged: (value) => setState(() {
          userResult.password = value;
        }),
        decoration: InputDecoration(
            labelText: 'Senha Atual',
            filled: false,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: _userPasswordController,
        onChanged: (value) => setState(() {
          userResult.password = value;
        }),
        decoration: InputDecoration(
            labelText: 'Nova Senha',
            filled: false,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    ]);
  }
}
