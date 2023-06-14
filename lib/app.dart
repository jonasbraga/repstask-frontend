import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/utils/themes.dart';
import 'package:reptask/utils/user_preferences.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUser = UserPreferences.myUser;

    return ThemeProvider(
      initTheme:
          (myUser.isDarkMode!) ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          title: 'Flutter Demo',
          // home: const ProfilePage(title: 'Perfil'),
          home: MyHomePage(title: 'Tarefas', user: myUser),
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
