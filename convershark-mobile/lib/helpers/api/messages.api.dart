import 'dart:convert';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:convershark/models/api_response.model.dart';
import 'config/config.api.dart';

Future<ApiResponse> sendMessage(String chatChannelId, String content) async {
  final response = await ApiClient()
      .post(API_MESSAGES, {"chatChannelId": chatChannelId, "content": content});
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
