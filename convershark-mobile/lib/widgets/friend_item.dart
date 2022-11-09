import 'package:app/screens/icons/my_flutter_app_icons.dart';
import 'package:app/utils/colors.dart';
import "package:flutter/material.dart";

class FriendItemWidget extends StatefulWidget {
  final String avatar;
  final String name;
  final String status;
  final String iconCall;
  final String iconMessage;

  const FriendItemWidget({
    Key? key,
    required this.avatar,
    required this.name,
    required this.status,
    required this.iconCall,
    required this.iconMessage,
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
              radius: 28,
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
                        style: const TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    Text(
                      widget.status,
                      style: const TextStyle(
                          color: friendTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    )
                  ]),
            ],
          )),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.square(35),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5),
                backgroundColor: friendButtonBackgroundColor,
              ),
              child: const Icon(MyFlutterApp.call,
                  color: friendIconColor, size: 16)),
          const SizedBox(width: 12),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.square(35),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5),
                backgroundColor: friendButtonBackgroundColor,
              ),
              child: const Icon(Icons.messenger,
                  color: friendIconColor, size: 16)),
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
