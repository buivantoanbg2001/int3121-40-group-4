import 'dart:convert';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:convershark/models/user.model.dart';
import 'config/config.api.dart';

Future<User> getMyInfo() async {
  final response = await ApiClient().get(API_USERS_ME);
  User user = User.fromJson(jsonDecode(response.body));
  return user;
}
