import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/models/message.model.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class ChatItemWidget extends StatefulWidget {
  final MessageModel message;

  const ChatItemWidget({Key? key, required this.message}) : super(key: key);

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
          backgroundImage: NetworkImage(widget.message.owner.avatar),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                widget.message.owner.name,
                style: const TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: Text(
                  inputFormat.format(DateTime.parse(widget.message.createdAt)),
                  style: const TextStyle(
                    color: chatTextDateColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 4),
            Text(
              widget.message.content,
              style: const TextStyle(color: whiteColor),
            )
          ],
        ),
      ]),
    );
  }
}
