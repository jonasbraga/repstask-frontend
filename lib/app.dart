import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/pages/login_page.dart';
import 'package:reptask/utils/themes.dart';
import 'package:reptask/utils/user_preferences.dart';

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
          home: const LoginPage(),
        ),
      ),
    );
  }
}
