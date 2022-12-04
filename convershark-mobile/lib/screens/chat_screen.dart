import 'dart:convert';
import 'package:convershark/helpers/api/chat_channel.api.dart';
import 'package:convershark/helpers/api/messages.api.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/models/chat_channel.model.dart';
import 'package:convershark/redux/app_state.dart';
import 'package:convershark/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ChatScreen extends StatefulWidget {
  final ChatChannelModel channel;

  const ChatScreen({super.key, required this.channel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatController = TextEditingController();
  late Future<ChatChannelModel> chatChannel;

  @override
  void initState() {
    super.initState();
    chatChannel = getChatChannel(widget.channel.id);
  }

  @override
  void dispose() {
    super.dispose();
    chatController.dispose();
  }

  void showBottomSheetInviteMemberToChatChannel(
      BuildContext context, String chatChannelId) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: bottomSheetBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Column(
            children: [
              const Text(
                "Mời bạn bè",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: StoreConnector<AppState, AppState>(
                      converter: (store) => store.state,
                      builder: (context, vm) => ListView.builder(
                          itemCount: vm.me.friends.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 16,
                                            backgroundImage: NetworkImage(
                                                vm.me.friends[index].avatar)),
                                        const SizedBox(width: 12),
                                        Text(vm.me.friends[index].uid,
                                            style: const TextStyle(
                                                color: whiteColor)),
                                        const Spacer(),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            backgroundColor:
                                                welcomeRegisterButtonColor,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Mời'),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: 32,
                                      indent: 44,
                                      color: index < vm.me.friends.length - 1
                                          ? notificationDividerColor
                                          : Colors.transparent,
                                    ),
                                  ],
                                ));
                          }))),
            ],
          ),
        );
      },
    );
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
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, vm) => Scaffold(
            backgroundColor: statusBarColor,
            appBar: AppBar(
                backgroundColor: chatHeaderColor,
                shape: const Border(
                    bottom: BorderSide(color: chatBorderColor, width: 1)),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: chatIconColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Row(
                  children: [
                    const Icon(
                      Icons.tag,
                      color: chatIconSecondaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.channel.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                actions: widget.channel.hostId == vm.me.id
                    ? <Widget>[
                        IconButton(
                          icon: const Icon(Icons.person_add_alt_1,
                              color: chatIconColor),
                          onPressed: () =>
                              showBottomSheetInviteMemberToChatChannel(
                                  context, widget.channel.id),
                        )
                      ]
                    : null),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: chatBodyColor,
                    width: screenSize.width,
                    child: FutureBuilder<ChatChannelModel>(
                        future: chatChannel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            ChatChannelModel data = snapshot.data!;

                            return ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 12),
                              itemCount: data.messages.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return ChatItemWidget(
                                  message: data.messages[index],
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const Center(
                            child: CircularProgressIndicator(
                              color: welcomeRegisterButtonColor,
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
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
                          hintText: "Nhắn ${widget.channel.name}",
                          hintStyle:
                              const TextStyle(color: chatTextSecondaryColor),
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
                            onPressed: () async {
                              if (chatController.text != "") {
                                String content = chatController.text;
                                ApiResponse res = await sendMessage(
                                    widget.channel.id, content);

                                if (res.isSuccess) {
                                  chatController.clear();
                                }
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
        ));
  }
}
