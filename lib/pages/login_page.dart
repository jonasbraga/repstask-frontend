import 'package:flutter/material.dart';
import 'package:reptask/controllers/login_controller.dart';
import 'package:reptask/models/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.loginSended});
  final LoginModel? loginSended;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late LoginModel login;
  final _RepublicaController = TextEditingController();
  final _UsuarioController = TextEditingController();
  final _SenhaController = TextEditingController();

    @override
  void initState() {
    super.initState();
    login = widget.loginSended ??
      LoginModel(rep: '', usuario: '', senha: '');
    _RepublicaController.text = login.rep;
    _UsuarioController.text = login.usuario.toString();
    _SenhaController.text = login.senha;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
      body: Padding(padding:EdgeInsets.all(10),
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
              Divider(),
              TextFormField(
                  autofocus: true,
                  controller: _RepublicaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "República",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.house),
                  ),
                  validator: (rep){
                    if(rep == null || rep.isEmpty){
                      return 'Digite sua república';
                    }
                    return null;
                  },
              ),
              Divider(),
              TextFormField(
                controller: _UsuarioController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Usuário",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (usuario){
                    if(usuario == null || usuario.isEmpty){
                      return 'Digite seu usuário';
                    }
                    return null;
                  },
              ),
              Divider(),
              TextFormField(
                controller: _SenhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                     prefixIcon: const Icon(Icons.key),
                  ),
                  validator: (senha){
                    if(senha == null || senha.isEmpty){
                      return 'Digite sua senha';
                    }
                    return null;
                  },
              ),
              Divider(),
              Container(
                width: 124,
                height: 36,
                child: TextButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        logar();
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      backgroundColor: const  Color.fromRGBO(13, 153, 255, 1),
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
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Esqueci a senha"),
                      SizedBox(width: 24,),
                      Text("Cadastrar república")
                    ],
                  ),
                )
            ], 
          ),
        ),
      )    
    );
  }

  logar() {
    LoginController().createLogin(login);
  }

}