import 'package:convershark/helpers/constains/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    );
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: kSigninBntColor, shape: const CircleBorder()),
          child: const Icon(
            Icons.expand_more,
            size: 26,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Name",
          selectionColor: Colors.black54,
          style: TextStyle(
              color: Colors.black12, fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: kSigninBntColor, shape: const CircleBorder()),
            child: const Icon(
              Icons.flip_camera_ios,
              size: 26,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: kSigninBntColor, shape: const CircleBorder()),
            child: const Icon(
              Icons.person_add,
              size: 26,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: kSigninBntColor, shape: const CircleBorder()),
            child: const Icon(
              Icons.chat_bubble,
              size: 26,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const SizedBox(height: 800),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: true,
            child: SlidingUpPanel(
              color: kSigninBntColor,
              controller: PanelController(),
              borderRadius: radius,
              panel: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder()),
                        child: const Icon(
                          Icons.videocam,
                          size: 36,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kSigninBntColor,
                            shape: const CircleBorder()),
                        child: const Icon(
                          Icons.mobile_screen_share,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kSigninBntColor,
                            shape: const CircleBorder()),
                        child: const Icon(
                          Icons.mic,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.square(50),
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(10),
                            shape: const CircleBorder()),
                        child: const Icon(
                          Icons.phone_disabled,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
