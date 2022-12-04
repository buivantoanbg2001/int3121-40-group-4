import 'package:convershark/helpers/api/notifications.api.dart';
import 'package:convershark/helpers/api/users.api.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/models/notification.model.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NotificationItemWidget extends StatefulWidget {
  final NotificationModel data;

  const NotificationItemWidget({Key? key, required this.data})
      : super(key: key);

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  final inputFormat = DateFormat('dd/MM/yyyy');
  bool isResponse = false;
  bool isAccept = false;

  void handleResponse(
      NotificationType type, bool isAccept, bool isResponse) async {
    ApiResponse res =
        await updateNotifications(widget.data.id, isAccept, isResponse);

    if (isAccept && res.isSuccess) {
      switch (type) {
        case NotificationType.FRIEND:
          {
            ApiResponse updateFriendResponse =
                await updateFriendsBoth(widget.data.sender.id);
            if (updateFriendResponse.isSuccess) {
              Fluttertoast.showToast(
                msg: updateFriendResponse.payload.message,
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: signinLoginButtonColor,
                textColor: whiteColor,
              );
            }
            break;
          }
        case NotificationType.SERVER:
          {
            break;
          }
        case NotificationType.CHAT:
          {
            break;
          }
        case NotificationType.CALL:
          {
            break;
          }
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          widget.data.chatId != null ||
                  widget.data.callId != null ||
                  widget.data.serverId != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      widget.data.chatId != null
                          ? Row(
                              children: [
                                const Icon(Icons.tag,
                                    color: whiteColor, size: 16),
                                Text(
                                  widget.data.chatId?.name ?? "",
                                  style: const TextStyle(color: whiteColor),
                                ),
                                const SizedBox(
                                  width: 12,
                                )
                              ],
                            )
                          : widget.data.callId != null
                              ? Row(
                                  children: [
                                    const Icon(Icons.tag,
                                        color: whiteColor, size: 16),
                                    Text(widget.data.callId?.name ?? "",
                                        style:
                                            const TextStyle(color: whiteColor)),
                                    const SizedBox(
                                      width: 12,
                                    )
                                  ],
                                )
                              : Container(),
                      Text(widget.data.serverId?.name ?? "",
                          style: const TextStyle(color: whiteColor)),
                    ],
                  ),
                )
              : Container(),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(widget.data.sender.avatar)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      widget.data.sender.name,
                      style: const TextStyle(color: whiteColor, fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        inputFormat
                            .format(DateTime.parse(widget.data.createdAt)),
                        style: const TextStyle(
                            color: chatTextDateColor, fontSize: 12),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  widget.data.type == NotificationType.FRIEND
                      ? Text(
                          "${widget.data.sender.name} đã gửi yêu cầu kết bạn.",
                          style: const TextStyle(color: whiteColor),
                        )
                      : widget.data.type == NotificationType.SERVER
                          ? Text(
                              "${widget.data.sender.name} đã gửi lời mời tham gia máy chủ ${widget.data.serverId?.name}.",
                              style: const TextStyle(color: whiteColor),
                            )
                          : widget.data.type == NotificationType.CHAT
                              ? Text(
                                  "${widget.data.sender.name} đã gửi lời mời tham gia kênh chat #${widget.data.chatId?.name}.",
                                  style: const TextStyle(color: whiteColor),
                                )
                              : widget.data.type == NotificationType.CALL
                                  ? Text(
                                      "${widget.data.sender.name} đã gửi lời mời tham gia kênh thoại #${widget.data.callId?.name}.",
                                      style: const TextStyle(color: whiteColor),
                                    )
                                  : widget.data.type == NotificationType.MESSAGE
                                      ? Text(
                                          "${widget.data.sender.name} đã đề cập đến bạn.",
                                          style: const TextStyle(
                                              color: whiteColor),
                                        )
                                      : const Text(
                                          "Không có nội dung",
                                          style: TextStyle(color: whiteColor),
                                        ),
                  widget.data.type != NotificationType.MESSAGE
                      ? !widget.data.isResponse && !isResponse
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(42),
                                        padding: EdgeInsets.zero,
                                        backgroundColor:
                                            welcomeRegisterButtonColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isResponse = true;
                                          isAccept = true;
                                        });
                                        handleResponse(
                                            widget.data.type, true, true);
                                      },
                                      child: const Text('Chấp nhận'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(42),
                                        padding: EdgeInsets.zero,
                                        backgroundColor:
                                            welcomeLoginButtonColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isResponse = true;
                                          isAccept = false;
                                        });
                                        handleResponse(
                                            widget.data.type, false, true);
                                      },
                                      child: const Text('Từ chối'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : widget.data.isAccept || isAccept
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(42),
                                        padding: EdgeInsets.zero,
                                        backgroundColor:
                                            welcomeRegisterButtonColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      onPressed: null,
                                      child: const Text('Các bạn đã là bạn bè'),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(42),
                                        padding: EdgeInsets.zero,
                                        backgroundColor:
                                            welcomeRegisterButtonColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      onPressed: null,
                                      child: const Text('Bạn đã từ chối'),
                                    ),
                                  ),
                                )
                      : Container(),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
