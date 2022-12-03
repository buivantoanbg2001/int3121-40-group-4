import 'package:convershark/helpers/constains/colors.dart';
import "package:flutter/material.dart";

enum GroupChannelTitleType { call, chat }

class GroupChannelTitleWidget extends StatelessWidget {
  final bool isExpand;
  final String name;

  const GroupChannelTitleWidget({
    Key? key,
    required this.isExpand,
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
          Icon(isExpand ? Icons.expand_more : Icons.chevron_right,
              size: 12, color: channelIconColor),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: channelIconColor),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
