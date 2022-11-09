import 'package:app/utils/colors.dart';
import "package:flutter/material.dart";

class AccountItemWidget extends StatelessWidget {
  final IconData iconData;
  final String name;
  final bool isHasChevron;
  final VoidCallback onTap;
  final List<Widget> actions;

  const AccountItemWidget(
      {Key? key,
      required this.iconData,
      required this.name,
      required this.isHasChevron,
      required this.onTap,
      required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: accountWidgetClickColor,
        highlightColor: accountWidgetClickColor,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(
              iconData,
              color: accountIconColor,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 16, color: whiteColor),
                ),
              ),
            ),
            Row(
              children: actions,
            ),
            if (isHasChevron)
              const Icon(
                Icons.chevron_right,
                size: 28,
                color: accountIconColor,
              ),
          ]),
        ),
      ),
    );
  }
}
