import 'package:convershark/helpers/constains/colors.dart';
import "package:flutter/material.dart";

class FriendItemWidget extends StatefulWidget {
  final String avatar;
  final String name;
  final String status;

  const FriendItemWidget({
    Key? key,
    required this.avatar,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  State<FriendItemWidget> createState() => _FriendItemWidgetState();
}

class _FriendItemWidgetState extends State<FriendItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(children: [
          CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(widget.avatar),
              child: Stack(children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: getWidget(widget.status),
                )
              ])),
          const SizedBox(width: 12),
          Expanded(
              child: Row(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text(
                        widget.name,
                        style: const TextStyle(color: whiteColor, fontSize: 14),
                      ),
                    ]),
                    Text(
                      widget.status,
                      style:
                          const TextStyle(color: friendTextColor, fontSize: 12),
                    )
                  ]),
            ],
          )),
        ]));
  }
}

Widget getWidget(String status) {
  if (status == "online") {
    return const CircleAvatar(
        radius: 8,
        backgroundColor: chatBodyColor,
        child: CircleAvatar(
          radius: 5,
          backgroundColor: friendStatusOnlineColor,
        ));
  } else {
    return const CircleAvatar(
        radius: 8,
        backgroundColor: chatBodyColor,
        child: CircleAvatar(
            radius: 5,
            backgroundColor: friendStatusOfflineColor,
            child: CircleAvatar(
              radius: 3,
              backgroundColor: friendBackgroundColor,
            )));
  }
}
