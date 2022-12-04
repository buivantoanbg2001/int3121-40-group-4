import 'dart:convert';
import 'package:convershark/helpers/constains/api.constains.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/models/chat_channel.model.dart';
import 'config/config.api.dart';

Future<ApiResponse> createChatChannel(
    String chatChannelName, String serverId) async {
  final response = await ApiClient()
      .post(API_CHAT_CHANNELS, {"name": chatChannelName, "serverId": serverId});
  ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
  return apiResponse;
}

Future<ChatChannelModel> getChatChannel(String chatChannelId) async {
  final response = await ApiClient().get('$API_CHAT_CHANNELS/$chatChannelId');
  ChatChannelModel chatChannel =
      ChatChannelModel.fromJson(jsonDecode(response.body));
  return chatChannel;
}
