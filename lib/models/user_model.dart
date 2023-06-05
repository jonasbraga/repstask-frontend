class UserModel {
  String name;
  String nickname;
  String? email;
  String password;
  int type;
  int repId;

  UserModel(
      {required this.name,
      required this.nickname,
      this.email,
      required this.password,
      required this.type,
      required this.repId});
}
