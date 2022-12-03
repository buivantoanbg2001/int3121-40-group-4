import 'package:convershark/helpers/constains/colors.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NotificationItemWidget extends StatefulWidget {
  final String serverName;
  final String channelName;
  final String avatar;
  final String name;
  final String message;
  final String createdAt;

  const NotificationItemWidget(
      {Key? key,
      required this.serverName,
      required this.channelName,
      required this.avatar,
      required this.name,
      required this.message,
      required this.createdAt})
      : super(key: key);

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  @override
  Widget build(BuildContext context) {
    final inputFormat = DateFormat('dd/MM/yyyy');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.tag,
                color: whiteColor,
                size: 16,
              ),
              Text(
                widget.channelName,
                style: const TextStyle(
                    color: whiteColor, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 12),
              Text(
                widget.serverName,
                style: const TextStyle(
                    color: whiteColor, fontWeight: FontWeight.w100),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(widget.avatar),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Text(
                      inputFormat.format(DateTime.parse(widget.createdAt)),
                      style: const TextStyle(
                        color: chatTextDateColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 4),
                Text(
                  widget.message,
                  style: const TextStyle(color: whiteColor),
                )
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
