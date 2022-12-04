import 'package:convershark/models/call_channel.model.dart';
import 'package:convershark/models/chat_channel.model.dart';

class Server {
  final String id;
  final String hostId;
  final String name;
  final List<ChatChannelModel> chatChannels;
  final List<CallChannel> callChannels;

  final String createdAt;

  const Server({
    required this.id,
    required this.hostId,
    required this.name,
    required this.chatChannels,
    required this.callChannels,
    required this.createdAt,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id: json['_id'],
      hostId: json['hostId'],
      name: json['name'],
      chatChannels: (json['chatChannels'] as List)
          .map((item) => ChatChannelModel.fromJson(item))
          .toList(),
      callChannels: (json['callChannels'] as List)
          .map((item) => CallChannel.fromJson(item))
          .toList(),
      createdAt: json['createdAt'],
    );
  }
}
