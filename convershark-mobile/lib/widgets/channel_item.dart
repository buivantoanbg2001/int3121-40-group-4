import 'package:app/utils/colors.dart';
import "package:flutter/material.dart";

enum ChannelItemType { callVideo, chat }

class ChannelItemWidget extends StatelessWidget {
  final ChannelItemType type;
  final String name;

  const ChannelItemWidget({
    Key? key,
    required this.type,
    required this.name,
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
            // type == ChannelItemType.callVideo
            //     ? Navigator.of(context).push(PrepareCallScreenPageRoute())
            //     : Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => const ChatScreen()),
            //       );
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
                    name,
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

// class PrepareCallScreenPageRoute extends PageRouteBuilder {
//   PrepareCallScreenPageRoute()
//       : super(
//             pageBuilder: (BuildContext context, Animation<double> animation,
//                     Animation<double> secondaryAnimation) =>
//                 const PrepareCallScreen());

//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return SlideTransition(
//       position:
//           Tween<Offset>(begin: const Offset(0, 1), end: const Offset(.0, .0))
//               .animate(controller!),
//       child: const PrepareCallScreen(),
//     );
//   }
// }
