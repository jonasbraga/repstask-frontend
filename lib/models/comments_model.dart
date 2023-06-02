class Comment {
  int? id;
  String comment;
  String userNick;
  int taskId;
  int userId;

  Comment(
      {this.id,
      required this.comment,
      required this.taskId,
      required this.userId,
      required this.userNick});
}
