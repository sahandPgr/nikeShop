class CommentEntity {
  final int id;
  final String? title;
  final String body;
  final String date;
  final String userName;

  CommentEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] ??='',
        body = json['body'],
        date = json['created_at'],
        userName = json['user_name'];
}
