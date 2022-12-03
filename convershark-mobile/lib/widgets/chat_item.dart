import 'package:convershark/helpers/constains/colors.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class ChatItemWidget extends StatefulWidget {
  final String avatar;
  final String name;
  final String message;
  final String createdAt;

  const ChatItemWidget(
      {Key? key,
      required this.avatar,
      required this.name,
      required this.message,
      required this.createdAt})
      : super(key: key);

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  @override
  Widget build(BuildContext context) {
    final inputFormat = DateFormat('dd/MM/yyyy');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(children: [
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
    );
  }
}
