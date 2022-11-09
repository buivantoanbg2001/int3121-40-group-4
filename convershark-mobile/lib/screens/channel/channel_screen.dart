import 'package:app/utils/colors.dart';
import 'package:app/widgets/channel_item.dart';
import 'package:app/widgets/group_channel_title.dart';
import 'package:flutter/material.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width - 58,
      color: statusBarColor,
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 72,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: index != 10 - 1
                                ? GestureDetector(
                                    child: const CircleAvatar(
                                      radius: 24,
                                      backgroundColor: channelBackgroundColor,
                                      backgroundImage: AssetImage(
                                        "assets/images/avatar.jpg",
                                      ),
                                    ),
                                  )
                                : RawMaterialButton(
                                    fillColor: channelBackgroundColor,
                                    elevation: 0,
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(12.0),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.add,
                                      color: channelIconAddColor,
                                    )),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  color: channelBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 20),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "J2Team",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: channelIconColor,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return const ExpansionTile(
                                backgroundColor: channelBackgroundColor,
                                title:
                                    GroupChannelTitleWidget(name: "KÊNH CHAT"),
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 6),
                                trailing:
                                    Icon(Icons.add, color: channelIconColor),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                children: <Widget>[
                                  ChannelItemWidget(
                                      type: ChannelItemType.chat,
                                      name: "chung"),
                                  ChannelItemWidget(
                                      type: ChannelItemType.callVideo,
                                      name: "Phòng chờ")
                                ],
                              );
                            }),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
