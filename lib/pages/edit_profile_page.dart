import 'dart:convert';
import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reptask/controllers/user_controller.dart';
import 'package:reptask/widget/profile_widget.dart';

import '../models/user_model.dart';
import '../widget/appbar_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, this.userInfo}) : super(key: key);
  final UserModel? userInfo;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserModel userResult;
  UserController userController = UserController();
  late bool _changeSenha = false;
  late bool _showPassword = false;
  late bool _showNewPassword = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userNicknameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    userResult = widget.userInfo ??
        UserModel(
          imagePath: 'Sem Imagem',
          name: 'name',
          email: 'email',
          nickname: 'nickname',
          password: '12345678',
          userType: 0,
          nomeRep: 'nomeRep',
          isDarkMode: false,
          userPoints: 'userPoints',
          userDoneTasks: 'userDoneTasks',
          id: 2,
        );
    _userNameController.text = userResult.name;
    _userNicknameController.text = userResult.nickname;
    _userPasswordController.text = userResult.password;
    _userNewPasswordController.text = '';
    // _userSenhaController.text = userResult.password;
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
                            imagePath: userResult.imagePath!,
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

                                debugPrint(base64Image.toString());

                                setState(
                                    () => userResult.imagePath = base64Image!);
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
                    userResult.name = value;
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
                    userResult.nickname = value;
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
                            userResult.password = value;
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
                            userResult.password = value;
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
                      updateUser(userResult);
                    },
                    child: const Center(
                      child: Text('Salvar'),
                    ))
              ],
            ),
          ),
        ),
      );

  updateUser(UserModel user) {
    userController.updateUser(user);
    return user;
  }
}
