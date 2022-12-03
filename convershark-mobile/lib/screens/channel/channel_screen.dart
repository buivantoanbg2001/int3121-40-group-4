import 'package:convershark/helpers/api/chat_channel.api.dart';
import 'package:convershark/helpers/api/servers.api.dart';
import 'package:convershark/helpers/api/users.api.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/helpers/fake_avatar.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/models/user.model.dart';
import 'package:convershark/widgets/channel_item.dart';
import 'package:convershark/widgets/group_channel_title.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

final storageBox = Hive.box("storageBox");

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  TextEditingController serverNameController = TextEditingController();
  TextEditingController chatChannelNameController = TextEditingController();
  TextEditingController callChannelNameController = TextEditingController();
  late Future<User> me;
  dynamic currentServer = storageBox.get("currentServer");
  dynamic currentChatChannel = storageBox.get("currentChatChannel");
  bool isExpandChatChannel = true;
  bool isExpandCallChannel = true;

  @override
  void initState() {
    super.initState();
    me = getMyInfo();
  }

  @override
  void dispose() {
    super.dispose();
    serverNameController.dispose();
    chatChannelNameController.dispose();
    callChannelNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width - 58,
      color: statusBarColor,
      child: SafeArea(
        child: FutureBuilder<User>(
          future: me,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  SizedBox(
                    width: 72,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.servers.length + 1,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: index != snapshot.data?.servers.length
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              currentServer = index;
                                              storageBox.put(
                                                  "currentServer", index);
                                              if (snapshot.data!.servers[index]
                                                  .chatChannels.isNotEmpty) {
                                                currentChatChannel = 0;
                                                storageBox.put(
                                                    "currentChatChannel", 0);
                                              } else {
                                                currentChatChannel = null;
                                                storageBox.delete(
                                                    "currentChatChannel");
                                              }
                                            });
                                          },
                                          child: currentServer == index
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration: const BoxDecoration(
                                                      color:
                                                          signinLoginButtonColor,
                                                      shape: BoxShape.circle),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                statusBarColor,
                                                            shape: BoxShape
                                                                .circle),
                                                    child: CircleAvatar(
                                                      radius: 22,
                                                      backgroundColor:
                                                          channelBackgroundColor,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        getAvatar(index),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      channelBackgroundColor,
                                                  backgroundImage: NetworkImage(
                                                    getAvatar(index),
                                                  ),
                                                ),
                                        )
                                      : RawMaterialButton(
                                          fillColor: channelBackgroundColor,
                                          elevation: 0,
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(12.0),
                                          onPressed: () {
                                            showModalBottomSheet<dynamic>(
                                              isScrollControlled: true,
                                              context: context,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.6,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: const BoxDecoration(
                                                      color:
                                                          bottomSheetBackgroundColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(
                                                                      8))),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "Tạo Máy Chủ Của Bạn",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      const Text(
                                                        "Máy chủ của bạn là nơi bạn giao lưu với bạn bè của mình. Hãy tạo máy chủ của riêng bạn và bắt đầu trò chuyện.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              welcomeSecondaryColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: TextField(
                                                          controller:
                                                              serverNameController,
                                                          cursorColor:
                                                              cursorColor,
                                                          style: const TextStyle(
                                                              color:
                                                                  whiteColor),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Nhập Tên Máy Chủ",
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color:
                                                                        bottomSheetTextSecondaryColor,
                                                                    fontSize:
                                                                        14),
                                                            filled: true,
                                                            fillColor:
                                                                bottomSheetBackgroundWidgetColor,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12.0,
                                                                    vertical:
                                                                        4.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              borderSide:
                                                                  const BorderSide(
                                                                width: 0,
                                                                style:
                                                                    BorderStyle
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          minimumSize: const Size
                                                              .fromHeight(42),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              welcomeRegisterButtonColor,
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                        ),
                                                        onPressed: () async {
                                                          final String name =
                                                              serverNameController
                                                                  .text;
                                                          ApiResponse
                                                              apiResponse =
                                                              await createServer(
                                                                  name);

                                                          if (apiResponse
                                                              .isSuccess) {
                                                            Navigator.pop(
                                                                context);

                                                            Fluttertoast
                                                                .showToast(
                                                              msg: apiResponse
                                                                  .payload
                                                                  .message,
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  signinLoginButtonColor,
                                                              textColor:
                                                                  whiteColor,
                                                            );

                                                            serverNameController
                                                                .clear();
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Tạo Máy Chủ'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: channelIconAddColor,
                                          )),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        color: channelBackgroundColor,
                        child: currentServer != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              snapshot.data!
                                                  .servers[currentServer].name,
                                              style: const TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.more_horiz,
                                            color: channelIconColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(42),
                                          padding: EdgeInsets.zero,
                                          backgroundColor:
                                              welcomeLoginButtonColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.person_add,
                                              color: whiteColor,
                                              size: 16,
                                            ),
                                            SizedBox(width: 6),
                                            Text('Lời mời'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Theme(
                                          data: ThemeData().copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            backgroundColor:
                                                channelBackgroundColor,
                                            title: GroupChannelTitleWidget(
                                                isExpand: isExpandChatChannel,
                                                name: "KÊNH CHAT"),
                                            onExpansionChanged: (value) {
                                              setState(() {
                                                isExpandChatChannel = value;
                                              });
                                            },
                                            initiallyExpanded: true,
                                            tilePadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 6),
                                            trailing: GestureDetector(
                                              child: const Icon(
                                                Icons.add,
                                                color: channelIconColor,
                                                size: 20,
                                              ),
                                              onTap: () {
                                                showModalBottomSheet<dynamic>(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.6,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              bottomSheetBackgroundColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            "Tạo Kênh Chat",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: whiteColor,
                                                              fontSize: 26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: TextField(
                                                              controller:
                                                                  chatChannelNameController,
                                                              cursorColor:
                                                                  cursorColor,
                                                              style: const TextStyle(
                                                                  color:
                                                                      whiteColor),
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Nhập Tên Kênh Chat",
                                                                hintStyle:
                                                                    const TextStyle(
                                                                        color:
                                                                            bottomSheetTextSecondaryColor,
                                                                        fontSize:
                                                                            14),
                                                                filled: true,
                                                                fillColor:
                                                                    bottomSheetBackgroundWidgetColor,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            12.0,
                                                                        vertical:
                                                                            4.0),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    width: 0,
                                                                    style:
                                                                        BorderStyle
                                                                            .none,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(42),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  welcomeRegisterButtonColor,
                                                              elevation: 0,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              final String
                                                                  name =
                                                                  chatChannelNameController
                                                                      .text;
                                                              ApiResponse
                                                                  apiResponse =
                                                                  await createChatChannel(
                                                                      name,
                                                                      snapshot
                                                                          .data!
                                                                          .servers[
                                                                              currentServer]
                                                                          .id);

                                                              if (apiResponse
                                                                  .isSuccess) {
                                                                Navigator.pop(
                                                                    context);

                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg: apiResponse
                                                                      .payload
                                                                      .message,
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      signinLoginButtonColor,
                                                                  textColor:
                                                                      whiteColor,
                                                                );

                                                                chatChannelNameController
                                                                    .clear();
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Tạo Kênh Chat'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                            children: <Widget>[
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: snapshot
                                                    .data!
                                                    .servers[currentServer]
                                                    .chatChannels
                                                    .length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  return ChannelItemWidget(
                                                      type:
                                                          ChannelItemType.chat,
                                                      name: snapshot
                                                          .data!
                                                          .servers[
                                                              currentServer]
                                                          .chatChannels[index]
                                                          .name);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        //
                                      ],
                                    ),
                                  ])
                            : const Center(
                                child: Text(
                                "Hãy Lựa Chọn Máy Chủ",
                                style: TextStyle(color: channelIconColor),
                              ))),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(
                child: CircularProgressIndicator(
              color: welcomeRegisterButtonColor,
            ));
          },
        ),
      ),
    );
  }
}
