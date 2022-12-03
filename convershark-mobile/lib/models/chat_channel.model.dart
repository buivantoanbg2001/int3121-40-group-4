class ChatChannel {
  final String id;
  final String hostId;
  final String name;

  const ChatChannel({
    required this.id,
    required this.hostId,
    required this.name,
  });

  factory ChatChannel.fromJson(Map<String, dynamic> json) {
    return ChatChannel(
      id: json['_id'],
      hostId: json['hostId'],
      name: json['name'],
    );
  }
}
