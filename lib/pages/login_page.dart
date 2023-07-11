import 'package:flutter/material.dart';
import 'package:reptask/controllers/login_controller.dart';
import 'package:reptask/models/login_model.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/pages/home_page.dart';

import '../components/bottom_modal.dart';
import '../components/user/create_rep_modal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.loginSended});
  final LoginModel? loginSended;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late LoginModel login;
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  // final loginController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    login = widget.loginSended ?? LoginModel(email: '', senha: '');
    _emailController.text = login.email;
    // _usuarioController.text = login.usuario.toString();
    _senhaController.text = login.senha;
    _loginController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 130,
                  height: 130,
                  child: Image.asset('assets/img/logo.png'),
                ),
                const Divider(),
                const Divider(),
                TextFormField(
                  autofocus: true,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu e-mail';
                    }
                    return null;
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.key),
                  ),
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Digite sua senha';
                    }
                    return null;
                  },
                ),
                const Divider(),
                SizedBox(
                  width: 124,
                  height: 36,
                  child: TextButton(
                      // onPressed: () {
                      //   if (_formKey.currentState!.validate()) {
                      //     logar(login);
                      //   }
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Atualizando o objeto login com as informações inseridas pelo usuário
                          login.email = _emailController.text;
                          login.senha = _senhaController.text;

                          // Agora você está passando o objeto atualizado para a função logar()
                          logar(login);
                        }
// },
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(8.0),
                        backgroundColor: const Color.fromRGBO(13, 153, 255, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.25,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                // TextFormField(
                //   controller: loginController,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // const Text("Esqueci a senha",
                      //     style: TextStyle(color: Colors.white)),
                      // const SizedBox(
                      //   width: 24,
                      // ),
                      InkWell(
                        onTap: () {
                          showModal(context, const CreateRepModal());
                        },
                        child: const Text("Cadastrar república",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> logar(LoginModel login) async {
    try {
      UserModel? response = await LoginController().createLogin(login);

      if (response != null) {
        UserModel user = response;
        debugPrint(user.toString());
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'Tarefas',
                  )),
        );
      }
    } catch (e) {
      debugPrint('Failed to login: $e');
      // handle the error appropriately
    }
  }
}
