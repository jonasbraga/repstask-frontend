import 'dart:convert';
import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reptask/controllers/user_controller.dart';
import 'package:reptask/widget/profile_widget.dart';

import '../models/user_model.dart';
import '../utils/user_preferences.dart';
import '../widget/appbar_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // late UserModel UserPreferences.myUser;
  UserController userController = UserController();
  late bool _changeSenha = false;
  late bool _showPassword = false;
  // late bool _showErrorDialog = false;
  late bool _showNewPassword = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userNicknameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _userNameController.text = UserPreferences.myUser.name;
    _userNicknameController.text = UserPreferences.myUser.nickname;
    _userPasswordController.text = '';
    _userNewPasswordController.text = '';
    // _userSenhaController.text = UserPreferences.myUser.password;
  }

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context, 'Editar Perfil', false),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    heightFactor: 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileWidget(
                            imagePath: UserPreferences.myUser.imagePath!,
                            isEdit: true,
                            onClicked: () async {
                              final ImagePicker picker = ImagePicker();
                              String? base64Image;
                              XFile? xImage = await picker.pickImage(
                                source: ImageSource.gallery,
                              );

                              if (xImage != null) {
                                List<int> imageBytes =
                                    File(xImage.path).readAsBytesSync();
                                base64Image = base64Encode(imageBytes);

                                setState(() => UserPreferences
                                    .myUser.imagePath = base64Image!);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _userNameController,
                  onChanged: (value) => setState(() {
                    UserPreferences.myUser.name = value;
                  }),
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _userNicknameController,
                  onChanged: (value) => setState(() {
                    UserPreferences.myUser.nickname = value;
                  }),
                  decoration: InputDecoration(
                      labelText: 'Apelido',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _changeSenha = !_changeSenha;
                    });
                  },
                  style: const ButtonStyle(
                      alignment: AlignmentDirectional.bottomStart),
                  child: const Text('Trocar Senha?'),
                ),
                // EditPassword(),
                !_changeSenha
                    ? const SizedBox(height: 12)
                    : Column(children: [
                        const SizedBox(height: 12),
                        TextField(
                          controller: _userPasswordController,
                          onChanged: (value) => setState(() {
                            UserPreferences.myUser.password = value;
                          }),
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(_showPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            labelText: 'Senha Atual',
                            filled: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _userNewPasswordController,
                          onChanged: (value) => setState(() {
                            UserPreferences.myUser.password = value;
                          }),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(_showNewPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onTap: () {
                                setState(() {
                                  _showNewPassword = !_showNewPassword;
                                });
                              },
                            ),
                            labelText: 'Nova Senha',
                            filled: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          obscureText: !_showNewPassword,
                        ),
                      ]),
                ElevatedButton(
                    onPressed: () {
                      updateUser(UserPreferences.myUser);
                    },
                    child: const Center(
                      child: Text('Salvar'),
                    ))
              ],
            ),
          ),
        ),
      );

  void updateUser(UserModel user) async {
    userController.updateUser(user);

    final String currentPassword = _userPasswordController.text;
    final String newPassword = _userNewPasswordController.text;
    final String newNickname = _userNicknameController.text;
    final String newName = _userNameController.text;
    final String newImage = UserPreferences.myUser.imagePath ?? '';

    if (currentPassword.isEmpty &&
        newPassword.isEmpty &&
        (newNickname.isNotEmpty || newName.isNotEmpty || newImage.isNotEmpty)) {
      userController.updateUser(user);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Dados Alterados com sucesso'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    if (currentPassword.isNotEmpty && newPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text('Por favor, digite uma nova senha.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (currentPassword.isEmpty && newPassword.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Aviso'),
          content: const Text('Por favor, informe a senha atual.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (currentPassword.isNotEmpty && newPassword.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => FutureBuilder(
          future:
              userController.updatePassword(user, currentPassword, newPassword),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.data == 200) {
                // limpa os campos de senha
                return AlertDialog(
                  title: const Text('Senha Alterada'),
                  content: const Text('Sua senha foi alterada com sucesso.'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                );
              } else {
                return AlertDialog(
                  title: const Text('Aviso'),
                  content: const Text('Senha inválida.'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                );
              }
            }
          },
        ),
      );

      _userPasswordController.text = '';
      _userNewPasswordController.text = '';
    }

    userController.updateUser(user);
  }
}
