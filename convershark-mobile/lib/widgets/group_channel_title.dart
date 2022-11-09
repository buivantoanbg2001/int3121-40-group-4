import 'package:app/utils/colors.dart';
import "package:flutter/material.dart";

enum GroupChannelTitleType { callVideo, chat }

class GroupChannelTitleWidget extends StatelessWidget {
  final String name;

  const GroupChannelTitleWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: channelWidgetClickColor,
        highlightColor: channelWidgetClickColor,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.expand_more, size: 16, color: channelIconColor),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: channelIconColor),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
