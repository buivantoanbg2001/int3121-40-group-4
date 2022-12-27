import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/models/call_channel.model.dart';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';

const appId = 'f713d0d0559846158aab1a1b8f12db62';
const channelName = 'call';
const token =
    '007eJxTYLBy8JBtSdl8/6Xl5AMFteaJUXXf7nrcMv9127TxRGe6S7QCQ5q5oXGKQYqBqamlhYmZoalFYmKSYaJhkkWaoVFKkplRg2JXckMgI4NHUhUTIwMEgvgsDMmJOTkMDABPiR76e';

class CallScreen extends StatefulWidget {
  final CallChannel channel;

  const CallScreen({Key? key, required this.channel}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final AgoraClient _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
    appId: appId,
    channelName: channelName,
    tempToken: token,
  ));

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Name"),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                AgoraVideoViewer(
                  client: _client,
                  layoutType: Layout.floating,
                  showNumberOfUsers: true,
                ),
                AgoraVideoButtons(
                  client: _client,
                  enabledButtons: const [
                    BuiltInButtons.toggleCamera,
                    BuiltInButtons.toggleMic,
                    BuiltInButtons.callEnd
                  ],
                  disconnectButtonChild: RawMaterialButton(
                    onPressed: () => Navigator.pop(context),
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
