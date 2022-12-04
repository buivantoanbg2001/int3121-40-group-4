import 'dart:convert';
import 'package:convershark/helpers/api/config/config.api.dart';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/models/notification.model.dart';

Future<ApiResponse> inviteFriend(String friendUid) async {
  final response = await ApiClient().post(API_NOTIFICATIONS,
      {"friendUID": friendUid, "type": NotificationType.FRIEND.name});
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

Future<List<NotificationModel>> getNotifications() async {
  final response = await ApiClient().get(API_NOTIFICATIONS);

  List<NotificationModel> notification = (jsonDecode(response.body) as List)
      .map((item) => NotificationModel.fromJson(item))
      .toList();

  return notification;
}

Future<ApiResponse> updateNotifications(
    String notificationId, bool isAccept, bool isResponse) async {
  final response = await ApiClient().patch('$API_NOTIFICATIONS/$notificationId',
      {'isAccept': isAccept, 'isResponse': isResponse});

  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
