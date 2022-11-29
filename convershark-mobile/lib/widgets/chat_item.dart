import "package:flutter/material.dart";

import '../utils/colors.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(children: [
        CircleAvatar(
          radius: 28,
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
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.5),
                child: Text(
                  widget.createdAt,
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 8),
            Text(
              widget.message,
              style: const TextStyle(
                  color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ]),
    );
  }
}
