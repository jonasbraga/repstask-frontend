import 'dart:convert';
import 'dart:ffi';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/controllers/user_controller.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/pages/profile_page.dart';
import 'package:reptask/utils/user_preferences.dart';
import 'package:reptask/widget/menu_wigget.dart';
import '../utils/themes.dart';
import '../utils/primary_color.dart';

AppBar buildAppBar(
    // class BuildAppBar extends AppBar {
    //   const BuildAppBar ({Key? key, }) : super (key: key);
    BuildContext context,
    String title,
    UserModel userParam,
    bool initPage) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  const icon = Icons.nightlight_round;
  UserModel user = UserPreferences.myUser;
  // UserController userController = UserController();

  // userController
  //     .getUsers(userParam.id)
  //     .then((userResults) => user = userResults);

  Widget buildImage() {
    final bytes = base64.decode(user.imagePath!);
    final imageProvider = MemoryImage(bytes);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageProvider,
          fit: BoxFit.cover,
          width: 32,
          height: 32,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ProfilePage(title: 'Perfil')),
              );
            },
          ),
        ),
      ),
    );
    //
  }

  return AppBar(
    title: Text(title),
    leading: initPage ? const MenuButton() : const BackButton(),
    backgroundColor: primaryColor,
    elevation: 0,
    actions: initPage
        ? [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  const Text('Pontos'),
                  const SizedBox(
                    height: 2,
                  ),
                  buildImage(),
                ],
              ),
            )
          ]
        : [
            ThemeSwitcher(
              builder: (context) => IconButton(
                icon: const Icon(icon),
                onPressed: () {
                  final theme =
                      isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;

                  final switcher = ThemeSwitcher.of(context);
                  switcher.changeTheme(theme: theme);
                },
              ),
            ),
          ],
  );
}
