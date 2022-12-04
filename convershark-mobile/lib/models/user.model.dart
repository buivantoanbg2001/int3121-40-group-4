import 'package:convershark/models/friend.model.dart';
import 'package:convershark/models/server.model.dart';

class UserModel {
  final String id;
  final String uid;
  final String name;
  final String email;
  final String status;
  final String wallpaper;
  final String avatar;
  final String bio;
  final List<FriendModel> friends;
  final List<Server> servers;
  final String createdAt;

  const UserModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.status,
    required this.wallpaper,
    required this.avatar,
    required this.bio,
    required this.friends,
    required this.servers,
    required this.createdAt,
  });

  factory UserModel.sample() {
    return const UserModel(
        id: '',
        uid: 'sample#0000',
        name: 'sample',
        email: 'sample@gmail.com',
        status: 'Online',
        wallpaper:
            'https://i.pinimg.com/736x/39/05/ca/3905ca871396b1715a90615a92466b0d.jpg',
        avatar:
            'https://user-images.githubusercontent.com/62609188/205458937-cf591903-c822-4e42-9d81-2af862943a60.jpg',
        bio: 'sample',
        friends: [],
        servers: [],
        createdAt: '2022-12-04T09:32:04Z');
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      uid: json['_uid'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      wallpaper: json['wallpaper'],
      avatar: json['avatar'],
      bio: json['bio'],
      friends: (json['friends'] as List)
          .map((item) => FriendModel.fromJson(item))
          .toList(),
      servers: (json['servers'] as List)
          .map((item) => Server.fromJson(item))
          .toList(),
      createdAt: json['createdAt'],
    );
  }
}
