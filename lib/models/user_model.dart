class UserModel {
  int? id;
  String? imagePath;
  String name;
  String email;
  String nickname;
  String password;
  int userType;
  String? nomeRep;
  String? userPoints;
  String? userDoneTasks;
  bool? isDarkMode;
  int repId;
  String token;

  UserModel({
    this.id,
    this.imagePath,
    required this.name,
    required this.email,
    required this.nickname,
    required this.password,
    required this.userType,
    this.userPoints,
    this.nomeRep,
    this.isDarkMode,
    this.userDoneTasks,
    required this.repId,
    required this.token,
  });

  // JsonMethods
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final imagePath = json['photo'];
    final name = json['name'];
    final email = json['email'];
    final nickname = json['nickname'];
    final password = json['password'];
    final userType = json['user_type'];
    final nomeRep = json['rep_name'];
    final userPoints = json['punctuation'].toString();
    final userDoneTasks = json['finished_tasks'];
    final isDarkMode = json['isDarkMode'];
    final id = json['id'];
    final repId = json['reps_id'];
    final token = json['token'];

    return UserModel(
      imagePath: imagePath,
      name: name,
      email: email,
      nickname: nickname,
      password: password,
      userType: userType,
      nomeRep: nomeRep,
      repId: repId,
      isDarkMode: isDarkMode,
      userPoints: userPoints,
      userDoneTasks: userDoneTasks,
      id: id,
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['photo'] = imagePath;
    json['name'] = name;
    json['email'] = email;
    json['nickname'] = nickname;
    json['password'] = password;
    json['user_type'] = userType;
    json['reps_id'] = repId;
    json['rep_name'] = nomeRep;
    // json['punctuation'] = userPoints;
    json['id'] = id;
    json['userDoneTasks'] = userDoneTasks;

    return json;
  }
}
