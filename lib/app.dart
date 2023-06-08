import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/pages/edit_profile_page.dart';
import 'package:reptask/pages/profile_page.dart';
import 'package:reptask/utils/primary_color.dart';
import 'package:reptask/utils/themes.dart';
import 'package:reptask/utils/user_preferences.dart';
import 'package:reptask/widget/photo_picker_widget.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return ThemeProvider(
      initTheme: (user.isDarkMode!) ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          title: 'Flutter Demo',
          // home: const ProfilePage(title: 'Perfil'),
          home: const MyHomePage(title: 'Tarefas'),
          //   home: ProfilePage(),
        ),
      ),
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: primaryColor,
    //   ),
    //   // home: const MyHomePage(title: 'Tarefas'),
    //   home: ProfilePage(),
    //   // home: EditProfilePage(),
    // );
  }
}
