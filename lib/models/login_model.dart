class LoginModel {
  String rep;
  String? usuario;
  String senha;

  LoginModel({
    required this.rep,
    required this.usuario,
    required this.senha,
  });

  // JsonMethods
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final rep = json['rep'];
    final usuario = json['user'];
    final senha = json['password'];

    return LoginModel(
        rep: rep,
        usuario: usuario,
        senha: senha,
      );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['rep'] = rep;
    json['user'] = usuario;
    json['password'] = senha;
    return json;
  }
}
