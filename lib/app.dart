import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/pages/login_page.dart';
import 'package:reptask/pages/edit_profile_page.dart';
import 'package:reptask/pages/profile_page.dart';
import 'package:reptask/pages/rep_page.dart';
import 'package:reptask/pages/shop_page.dart';
import 'package:reptask/pages/user_page.dart';
import 'package:reptask/utils/primary_color.dart';
import 'package:reptask/utils/themes.dart';
import 'package:reptask/utils/user_preferences.dart';
import 'package:reptask/widget/photo_picker_widget.dart';
import 'models/user_model.dart';
import 'pages/home_page.dart';
import 'pages/cadastro_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    UserModel useeer = UserPreferences.myUser;
    return ThemeProvider(
      initTheme: (user.isDarkMode!) ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          title: 'Flutter Demo',
          home: const LoginPage(),
          // home: ProfilePage(user: useeer, title: 'Perfil'),
          // home: ProfilePage(),
          // home: MyHomePage(title: 'Tarefas', user: useeer),
          // home: UserPage(title: 'Usuários', user: useeer),
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
