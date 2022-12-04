class MessageOwner {
  final String id;
  final String name;
  final String avatar;

  const MessageOwner({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory MessageOwner.fromJson(Map<String, dynamic> json) {
    return MessageOwner(
      id: json['_id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}

class MessageModel {
  final String id;
  final MessageOwner owner;
  final String content;
  final String createdAt;

  const MessageModel({
    required this.id,
    required this.owner,
    required this.content,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      owner: MessageOwner.fromJson(json['ownerId']),
      content: json['content'],
      createdAt: json['createdAt'],
    );
  }
}
