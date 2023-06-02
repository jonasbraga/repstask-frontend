class Comment {
  int? id;
  String comment;
  int taskId;
  int userId;

  Comment({
    this.id,
    required this.comment,
    required this.taskId,
    required this.userId
  });
}
