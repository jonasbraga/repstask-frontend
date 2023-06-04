import 'package:flutter/material.dart';
import 'package:reptask/controllers/cadastro_controller.dart';
import 'package:reptask/models/cadastro_model.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({super.key, this.cadastroSended});
  CadastroModel? cadastroSended;

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  late CadastroModel login;
  final _RepublicaController = TextEditingController();
  final _UsuarioController = TextEditingController();
  final _SenhaController = TextEditingController();

    @override
  void initState() {
    super.initState();
    login = widget.cadastroSended ??
      CadastroModel(rep: "rep", usuario: "chey", senha: "1234c", email: "chey@gmail.com");
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
                 keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (email){
                    if(email == null || email.isEmpty){
                      return 'Digite seu e-mail';
                    }
                    return null;
                  },
              ),
              Divider(),
              TextFormField(
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
                      'CADASTRAR',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
                )
            ], 
          ),  
        ),
      )    
    );
  }
}