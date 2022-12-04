import 'dart:convert';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/models/user.model.dart';
import 'config/config.api.dart';

Future<UserModel> getMyInfo() async {
  final response = await ApiClient().get(API_USERS_ME);
  UserModel user = UserModel.fromJson(jsonDecode(response.body));
  return user;
}

Future<ApiResponse> updateFriendsBoth(String friendId) async {
  final response =
      await ApiClient().patch('$API_USERS_UPDATE_FRIENDS_BOTH/$friendId');
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
