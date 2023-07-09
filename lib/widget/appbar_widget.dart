import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/pages/profile_page.dart';
import 'package:reptask/utils/user_preferences.dart';
import '../utils/themes.dart';
import '../utils/primary_color.dart';

AppBar buildAppBar(BuildContext context, String title, bool initPage) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  const icon = Icons.nightlight_round;

  Widget buildImage() {
    final bytes = base64.decode(UserPreferences.myUser.imagePath!);
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
    backgroundColor: primaryColor,
    elevation: 0,
    actions: initPage
        ? [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                // decoration: BoxDecoration(backgroundBlendMode: ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(56),
                  color: ColorTween(
                    begin: Color(primaryColor.value),
                    end: Colors.white,
                  ).lerp(0.1),
                ),

                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    Text(UserPreferences.myUser.userPoints!),
                    const SizedBox(width: 6),
                    const Text('Pontos'),
                    const SizedBox(width: 6),
                    buildImage(),
                    const SizedBox(width: 6),
                  ],
                ),
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
