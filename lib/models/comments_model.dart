class Comment {
  int? id;
  String comment;
  String userNick;
  int taskId;
  int userId;
  String? userPhoto;

  Comment(
      {this.id,
      required this.comment,
      required this.taskId,
      required this.userId,
      this.userPhoto,
      required this.userNick});
}
