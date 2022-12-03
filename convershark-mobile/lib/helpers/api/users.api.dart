import 'dart:convert';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:convershark/models/user.model.dart';
import 'config/config.api.dart';
import 'package:hive/hive.dart';

final _storageBox = Hive.box("storageBox");

Future<User> getMyInfo() async {
  final response = await ApiClient().get(API_USERS_ME);
  User user = User.fromJson(jsonDecode(response.body));

  if (user.servers.isNotEmpty) {
    _storageBox.put("currentServer", 0);
    if (user.servers[0].chatChannels.isNotEmpty) {
      _storageBox.put("currentChatChannel", 0);
    } else {
      _storageBox.delete("currentChatChannel");
    }
  } else {
    _storageBox.delete("currentServer");
  }

  return user;
}
