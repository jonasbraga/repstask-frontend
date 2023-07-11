import 'package:flutter/material.dart';

import '../../controllers/login_controller.dart';
import '../../models/rep_model.dart';

class CreateRepModal extends StatefulWidget {
  const CreateRepModal({super.key});

  @override
  State<CreateRepModal> createState() => _CreateRepModalState();
}

class _CreateRepModalState extends State<CreateRepModal> {
  bool obscurePassword = true;
  TextEditingController repNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userNicknameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Novo pedido de criação \nde república',
                softWrap: true,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    fontSize: 24,
                    letterSpacing: 0.15)),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Color.fromRGBO(0, 0, 0, 0.87),
                ))
          ],
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 12),
          child: TextFormField(
            controller: repNameController,
            decoration: const InputDecoration(
                labelText: 'Nome da República',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 12),
          child: TextFormField(
            controller: userNameController,
            decoration: const InputDecoration(
                labelText: 'Nome do admin',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 12),
          child: TextFormField(
            controller: userNicknameController,
            decoration: const InputDecoration(
                labelText: 'Apelido do admin',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 12),
          child: TextFormField(
            controller: userEmailController,
            decoration: const InputDecoration(
                labelText: 'Email do admin',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder()),
          ),
        ),
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: 12),
          child: TextField(
            controller: userPasswordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
                labelText: "Senha do admin",
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        if (obscurePassword) {
                          obscurePassword = false;
                        } else {
                          obscurePassword = true;
                        }
                      });
                    },
                    icon: Icon(obscurePassword == true
                        ? Icons.remove_red_eye
                        : Icons.password))),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 20,
          margin: const EdgeInsets.only(top: 32, bottom: 36),
          child: TextButton(
              onPressed: () {
                createRepFunction();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'SOLICITAR',
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1.25, fontSize: 16),
              )),
        )
      ],
    );
  }

  void createRepFunction() {
    final repData = RepModel(
        nameRep: userNameController.text,
        name: userNameController.text,
        nickname: userNicknameController.text,
        password: userPasswordController.text,
        email: userEmailController.text);
    LoginController().createNewRequestRep(repData);
  }
}
