class MessageModel {
  final String title;
  final String content;
  final int createdAt;

  MessageModel({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      title: json['title'],
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content, 'createdAt': createdAt};
  }
}
