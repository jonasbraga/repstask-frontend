import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(70, 4, 138, 1),
      body: Padding(padding:EdgeInsets.all(10),
        child: Center(
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
                  ),
              ),
              Divider(),
              TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Usuário",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.white,
                    filled: true,
                  ),
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
                  ),
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
                  ),
              ),
              Divider(),
              Container(
                width: 124,
                height: 36,
                child: TextButton(
                    onPressed: () {},
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