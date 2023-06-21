class LoginModel {
  String rep;
  String usuario;
  String senha;

  LoginModel({
    required this.rep,
    required this.usuario,
    required this.senha,
  });

  // JsonMethods
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final rep = json['rep'];
    final usuario = json['email'];
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
    json['email'] = usuario;
    json['password'] = senha;
    return json;
  }
}
