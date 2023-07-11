import 'package:flutter/material.dart';
import 'package:reptask/pages/login_page.dart';
import 'package:reptask/pages/rep_page.dart';

import '../../pages/home_page.dart';
import '../../pages/shop_page.dart';
import '../../pages/user_page.dart';
import '../../utils/user_preferences.dart';

var drawerActivePage = '';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 48,
        ),
        const Divider(),
        Column(
          children: [
            ListTile(
              selected: drawerActivePage == 'home',
              selectedColor: const Color.fromRGBO(70, 4, 138, 1),
              selectedTileColor: const Color.fromRGBO(151, 151, 151, 0.3),
              leading: const Icon(Icons.home),
              title: const Text(
                "Tarefas",
              ),
              onTap: () {
                if (drawerActivePage != 'home') {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'Tarefas')));
                  drawerActivePage = 'home';
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            ListTile(
              selected: drawerActivePage == 'shop',
              selectedColor: const Color.fromRGBO(70, 4, 138, 1),
              selectedTileColor: const Color.fromRGBO(151, 151, 151, 0.3),
              leading: const Icon(Icons.store),
              title: const Text("Loja de Pontos"),
              onTap: () {
                if (drawerActivePage != 'shop') {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ShopPage()));
                  drawerActivePage = 'shop';
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            ListTile(
              selected: drawerActivePage == 'rep',
              selectedColor: const Color.fromRGBO(70, 4, 138, 1),
              selectedTileColor: const Color.fromRGBO(151, 151, 151, 0.3),
              leading: const Icon(Icons.group),
              title: const Text("Moradores"),
              onTap: () {
                if (drawerActivePage != 'rep') {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => UserPage(
                          title: 'Moradores', user: UserPreferences.myUser)));
                  drawerActivePage = 'rep';
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            ListTile(
              selectedColor: const Color.fromRGBO(70, 4, 138, 1),
              selectedTileColor: const Color.fromRGBO(151, 151, 151, 0.3),
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            )
          ],
        )
      ],
    );
  }
}
