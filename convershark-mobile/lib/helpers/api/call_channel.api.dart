import 'dart:convert';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:convershark/models/api_response.model.dart';
import 'config/config.api.dart';

Future<ApiResponse> createCallChannel(
    String callChannelName, String serverId) async {
  final response = await ApiClient()
      .post(API_CALL_CHANNELS, {"name": callChannelName, "serverId": serverId});
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}
