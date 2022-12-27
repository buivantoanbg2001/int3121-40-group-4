import 'package:convershark/models/call_channel.model.dart';
import 'package:convershark/screens/call_screen.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PrepareCallScreen extends StatefulWidget {
  final CallChannel channel;

  const PrepareCallScreen({Key? key, required this.channel}) : super(key: key);

  @override
  State<PrepareCallScreen> createState() => _PrepareCallScreenState();
}

class _PrepareCallScreenState extends State<PrepareCallScreen> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    );
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: kSigninBntColor, shape: const CircleBorder()),
          child: const Icon(
            Icons.expand_more,
            size: 26,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: const <Widget>[
            Icon(
              Icons.volume_up,
              color: kPrimaryLightColor,
            ),
            Text(
              " Chat",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kPrimaryLightColor),
            ),
          ],
        ),
        actions: <Widget>[
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
          Positioned(
            top: 190,
            left: 70,
            right: 65,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: kSigninBntColor,
                  shape: const CircleBorder()),
              child: const Icon(
                Icons.volume_up,
                size: 58,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            top: 250,
            left: 50,
            right: 50,
            child: Text(
              "Chưa có ai ở đây cả",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryLightColor),
            ),
          ),
          const Positioned(
            top: 300,
            left: 70,
            right: 65,
            child: Text(
              "Kênh thoại là để tán gẫu. Khi bạn đã sẵn sàng trò chuyện, chỉ cần nhảy vào tham gia. Bạn bè cũng có thể thấy và tham gia cùng bạn. Giống như sử dụng thần giao cách cảm để chào hỏi vậy.",
              textAlign: TextAlign.center,
              style: TextStyle(color: kPrimaryLightColor),
            ),
          ),
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
                            backgroundColor: Colors.blueGrey),
                        child: const Icon(Icons.mic, size: 36),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CallScreen(
                                        channel: widget.channel,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.green),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Tham gia'),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.volume_up,
                              size: 40.0,
                            ),
                          ],
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
