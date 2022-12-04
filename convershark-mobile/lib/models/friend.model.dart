class FriendModel {
  final String id;
  final String uid;
  final String status;
  final String wallpaper;
  final String avatar;
  final String bio;
  final String createdAt;

  const FriendModel({
    required this.id,
    required this.uid,
    required this.status,
    required this.wallpaper,
    required this.avatar,
    required this.bio,
    required this.createdAt,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['_id'],
      uid: json['_uid'],
      status: json['status'],
      wallpaper: json['wallpaper'],
      avatar: json['avatar'],
      bio: json['bio'],
      createdAt: json['createdAt'],
    );
  }
}
