import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/screens/chat_screen.dart';
import 'package:convershark/screens/prepare_call_screen.dart';
import "package:flutter/material.dart";

enum ChannelItemType { callVideo, chat }

class ChannelItemWidget extends StatelessWidget {
  final int index;
  final ChannelItemType type;
  final dynamic channel;

  const ChannelItemWidget({
    Key? key,
    required this.index,
    required this.type,
    required this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: channelWidgetClickColor,
          highlightColor: channelWidgetClickColor,
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            type == ChannelItemType.callVideo
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrepareCallScreen(
                              channel: channel,
                            )),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(channel: channel)),
                  );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                type == ChannelItemType.callVideo
                    ? Icons.volume_up_rounded
                    : Icons.tag,
                color: channelIconColor,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Text(
                    channel.name,
                    style:
                        const TextStyle(fontSize: 16, color: channelIconColor),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
