import 'package:convershark/models/message.model.dart';

class ChatChannelModel {
  final String id;
  final String hostId;
  final String name;
  final List<MessageModel> messages;

  const ChatChannelModel({
    required this.id,
    required this.hostId,
    required this.name,
    required this.messages,
  });

  factory ChatChannelModel.fromJson(Map<String, dynamic> json) {
    return ChatChannelModel(
      id: json['_id'],
      hostId: json['hostId'],
      name: json['name'],
      messages: (json['messages'] as List).isEmpty ||
              (json['messages'] as List)[0] is String
          ? []
          : (json['messages'] as List)
              .map((item) => MessageModel.fromJson(item))
              .toList(),
    );
  }
}
