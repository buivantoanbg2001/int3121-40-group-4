class CallChannel {
  final String id;
  final String hostId;
  final String name;

  const CallChannel({
    required this.id,
    required this.hostId,
    required this.name,
  });

  factory CallChannel.fromJson(Map<String, dynamic> json) {
    return CallChannel(
      id: json['_id'],
      hostId: json['hostId'],
      name: json['name'],
    );
  }
}
