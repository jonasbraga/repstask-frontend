import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:reptask/controllers/streams_controller.dart';
import 'package:reptask/controllers/user_controller.dart';
import 'package:reptask/pages/edit_profile_page.dart';
import 'package:reptask/utils/primary_color.dart';
import 'package:reptask/widget/appbar_widget.dart';
import 'package:reptask/widget/profile_widget.dart';
import '../models/user_model.dart';
import 'package:reptask/utils/user_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController userController = UserController();
  UserModel userResult = UserPreferences.myUser;

  @override
  void initState() {
    super.initState();
    refreshUserPageStream.stream.listen((event) {
      refreshPage();
    });
    userController
        .getUsers()
        .then((userResults) => setState(() => userResult = userResults));
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context, 'Perfil', false),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 2),
                          SizedBox(
                              width: 60,
                              // height: 80,
                              child: Column(
                                children: [
                                  const Text(
                                    'Tarefas\nConcluídas:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    userResult.userDoneTasks,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                          Column(
                            children: [
                              ProfileWidget(
                                imagePath: userResult.imagePath!,
                                onClicked: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage(
                                            userInfo: userResult)),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                    userResult.userType == 1
                                        ? 'Admin'
                                        : 'Morador',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Pontos\nAcumulados:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  userResult.userPoints,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 2),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(userResult.nickname.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              buildName(userResult),
              const SizedBox(height: 24),
              // buildAbout(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(UserModel user) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 12),
        Text(
          user.email,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 48),
        const Text(
          'República:',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          user.nomeRep,
          style: const TextStyle(fontSize: 24),
        )
      ],
    );
  }

  Widget buildAbout(UserModel user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            user.nickname,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
  }

  Future<void> refreshPage() async {
    userController
        .getUsers()
        .then((userResults) => setState(() => userResult = userResults));
  }
}
