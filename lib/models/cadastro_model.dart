class CadastroModel {
  String rep;
  String? usuario;
  String senha;
  String? email;

  CadastroModel({
    required this.rep,
    required this.usuario,
    required this.senha,
    required this.email,
  });

  // JsonMethods
  factory CadastroModel.fromJson(Map<String, dynamic> json) {
    final rep = json['rep'];
    final usuario = json['user'];
    final senha = json['password'];
    final email = json['email'];

    return CadastroModel(
        rep: rep,
        usuario: usuario,
        senha: senha,
        email: email,
      );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['rep'] = rep;
    json['user'] = usuario;
    json['password'] = senha;
    json['email'] =  email;
    return json;
  }
}
