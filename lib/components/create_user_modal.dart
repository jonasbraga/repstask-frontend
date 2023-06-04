import 'package:flutter/material.dart';

class CreateUserModal extends StatefulWidget {
  const CreateUserModal({super.key});

  @override
  State<CreateUserModal> createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  bool obscurePassword = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Novo Morador',
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
            controller: userNameController,
            decoration: const InputDecoration(
                labelText: 'Nome',
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
                labelText: 'Email',
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
                labelText: "Senha",
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
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'CRIAR',
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1.25, fontSize: 16),
              )),
        )
      ],
    );
  }
}
