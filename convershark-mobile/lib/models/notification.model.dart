class NotificationSender {
  final String id;
  final String uid;
  final String name;
  final String avatar;

  const NotificationSender({
    required this.id,
    required this.uid,
    required this.name,
    required this.avatar,
  });

  factory NotificationSender.fromJson(Map<String, dynamic> json) {
    return NotificationSender(
      id: json['_id'],
      uid: json['_uid'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}

class NotificationServer {
  final String id;
  final String name;

  const NotificationServer({
    required this.id,
    required this.name,
  });

  factory NotificationServer.fromJson(Map<String, dynamic> json) {
    return NotificationServer(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class NotificationChannel {
  final String id;
  final String name;

  const NotificationChannel({
    required this.id,
    required this.name,
  });

  factory NotificationChannel.fromJson(Map<String, dynamic> json) {
    return NotificationChannel(
      id: json['_id'],
      name: json['name'],
    );
  }
}

enum NotificationType { FRIEND, MESSAGE, SERVER, CALL, CHAT }

class NotificationModel {
  final String id;
  final NotificationSender sender;
  final String receiver;
  final NotificationType type;
  final NotificationServer? serverId;
  final NotificationChannel? chatId;
  final NotificationChannel? callId;
  final bool isResponse;
  final bool isAccept;
  final String createdAt;

  const NotificationModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.type,
    this.serverId,
    this.chatId,
    this.callId,
    required this.isResponse,
    required this.isAccept,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      sender: NotificationSender.fromJson(json['sender']),
      receiver: json['receiver'],
      type: NotificationType.values.firstWhere((e) => e.name == json['type']),
      serverId: json['serverId'] != null
          ? NotificationServer.fromJson(json['serverId'])
          : null,
      chatId: json['chatId'] != null
          ? NotificationChannel.fromJson(json['chatId'])
          : null,
      callId: json['callId'] != null
          ? NotificationChannel.fromJson(json['callId'])
          : null,
      isResponse: json['isResponse'],
      isAccept: json['isAccept'],
      createdAt: json['createdAt'],
    );
  }
}
