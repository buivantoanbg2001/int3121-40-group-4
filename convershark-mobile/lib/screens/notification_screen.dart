import 'package:convershark/helpers/api/notifications.api.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/models/notification.model.dart';
import 'package:convershark/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = getNotifications();
  }

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
          child: FutureBuilder<List<NotificationModel>>(
            future: notifications,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<NotificationModel> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        NotificationItemWidget(data: data[index]),
                        Divider(
                          height: 20,
                          endIndent: 20,
                          color: index < data.length - 1
                              ? notificationDividerColor
                              : Colors.transparent,
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: welcomeRegisterButtonColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
