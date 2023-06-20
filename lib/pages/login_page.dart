import 'package:flutter/material.dart';
import 'package:reptask/controllers/login_controller.dart';
import 'package:reptask/models/login_model.dart';
import 'package:reptask/models/user_model.dart';
import 'package:reptask/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.loginSended});
  final LoginModel? loginSended;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late LoginModel login;
  final TextEditingController _republicaController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  // final loginController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    login = widget.loginSended ?? LoginModel(rep: '', usuario: '', senha: '');
    _republicaController.text = login.rep;
    _usuarioController.text = login.usuario.toString();
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
                TextFormField(
                  autofocus: true,
                  controller: _republicaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "República",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.house),
                  ),
                  validator: (rep) {
                    if (rep == null || rep.isEmpty) {
                      return 'Digite sua república';
                    }
                    return null;
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Usuário",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (usuario) {
                    if (usuario == null || usuario.isEmpty) {
                      return 'Digite seu usuário';
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
                          login.rep = _republicaController.text;
                          login.usuario = _usuarioController.text;
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
                  padding: const EdgeInsets.only(top: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text("Esqueci a senha"),
                      SizedBox(
                        width: 24,
                      ),
                      Text("Cadastrar república")
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

        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'Tarefas', user: user)),
        );
      }
    } catch (e) {
      debugPrint('Failed to login: $e');
      // handle the error appropriately
    }
  }
}
