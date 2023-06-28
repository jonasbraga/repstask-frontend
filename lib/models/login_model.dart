class LoginModel {
  String email;
  String senha;

  LoginModel({
    required this.email,
    required this.senha,
  });

  // JsonMethods
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final email = json['email'];
    final senha = json['password'];

    return LoginModel(
      email: email,
      senha: senha,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['email'] = email;
    json['password'] = senha;
    return json;
  }
}
