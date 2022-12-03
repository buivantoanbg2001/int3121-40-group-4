import 'dart:convert';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import '../../helpers/overlapping_panels.dart';

class Chat {
  final String avatar;
  final String name;
  final String message;
  final String createdAt;

  Chat(this.name, this.avatar, this.message, this.createdAt);

  Chat.fromJson(Map<String, dynamic> json)
      : avatar = json['avatar'],
        name = json['name'],
        message = json['message'],
        createdAt = json['createdAt'];
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatController = TextEditingController();

  List<Chat> chatList = (jsonDecode(
              '[{"name":"John","message":"Hi","avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","createdAt":"2022-10-20T10:10:10Z"},{"name":"John","message":"Hello","avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","createdAt":"2022-10-19T10:10:10Z"}]')
          as List)
      .map((item) => Chat.fromJson(item))
      .toList();

  @override
  void dispose() {
    super.dispose();
    chatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: statusBarColor,
        appBar: AppBar(
            backgroundColor: chatHeaderColor,
            shape: const Border(
                bottom: BorderSide(color: chatBorderColor, width: 1)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: chatIconColor),
              onPressed: () {
                if (OverlappingPanels.of(context)?.translate == 0) {
                  OverlappingPanels.of(context)?.reveal(RevealSide.left);
                } else {
                  OverlappingPanels.of(context)?.reveal(RevealSide.main);
                }
              },
            ),
            title: Row(
              children: const [
                Icon(
                  Icons.tag,
                  color: chatIconSecondaryColor,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "kênh-công-chúa",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.person_add_alt_1, color: chatIconColor),
                onPressed: () {},
              )
            ]),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  color: chatBodyColor,
                  width: screenSize.width,
                  child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 12),
                      itemCount: chatList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ChatItemWidget(
                            avatar: chatList[index].avatar,
                            name: chatList[index].name,
                            message: chatList[index].message,
                            createdAt: chatList[index].createdAt);
                      })),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: const BoxDecoration(
                  color: chatBodyColor,
                  border: Border(
                      top: BorderSide(width: 1, color: chatBorderColor))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    cursorColor: cursorColor,
                    style: const TextStyle(color: whiteColor),
                    controller: chatController,
                    decoration: InputDecoration(
                      hintText: "Nhắn #kênh-công-chúa",
                      hintStyle: const TextStyle(color: chatTextSecondaryColor),
                      filled: true,
                      fillColor: chatBackgroundWidgetColor,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: chatIconColor),
                        padding: const EdgeInsets.only(right: 12.0),
                        onPressed: () {
                          if (chatController.text != "") {
                            Map<String, dynamic> chatItemJson = {
                              "name": "John",
                              "message": chatController.text,
                              "avatar":
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU",
                              "createdAt": "2022-10-20T10:10:10Z"
                            };
                            chatController.clear();
                            setState(() {
                              chatList.add(Chat.fromJson(chatItemJson));
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
