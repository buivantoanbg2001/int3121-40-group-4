import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: notificationHeadColor,
        shape: const Border(
            bottom: BorderSide(color: notificationBorderColor, width: 1)),
        elevation: 0,
        title: const Text(
          "Thông báo",
          style: TextStyle(fontSize: 20),
        ),
      ),
      backgroundColor: notificationBodyColor,
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: ListView.builder(
              itemCount: 16,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const NotificationItemWidget(
                        serverName: "Clash Of Clans",
                        channelName: "clan-battle",
                        avatar:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU",
                        name: "Văn Toán",
                        message: "Hello World",
                        createdAt: "2022-10-20T10:10:10Z"),
                    Divider(
                      height: 20,
                      thickness: index != 16 - 1 ? 1 : 0,
                      endIndent: 20,
                      color: notificationDividerColor,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
