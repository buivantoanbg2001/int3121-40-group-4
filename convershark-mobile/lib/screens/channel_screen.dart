import 'package:convershark/helpers/api/chat_channel.api.dart';
import 'package:convershark/helpers/api/servers.api.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/helpers/fake_avatar.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/redux/actions.dart';
import 'package:convershark/redux/app_state.dart';
import 'package:convershark/widgets/channel_item.dart';
import 'package:convershark/widgets/group_channel_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  TextEditingController serverNameController = TextEditingController();
  TextEditingController chatChannelNameController = TextEditingController();
  TextEditingController callChannelNameController = TextEditingController();
  bool isExpandChatChannel = true;
  bool isExpandCallChannel = true;

  @override
  void dispose() {
    super.dispose();
    serverNameController.dispose();
    chatChannelNameController.dispose();
    callChannelNameController.dispose();
  }

  void showBottomSheetCreateServer(BuildContext context) {
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
                "Tạo Máy Chủ Của Bạn",
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
              const Text(
                "Máy chủ của bạn là nơi bạn giao lưu với bạn bè của mình. Hãy tạo máy chủ của riêng bạn và bắt đầu trò chuyện.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: welcomeSecondaryColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: serverNameController,
                  cursorColor: cursorColor,
                  style: const TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    hintText: "Nhập Tên Máy Chủ",
                    hintStyle: const TextStyle(
                        color: bottomSheetTextSecondaryColor, fontSize: 14),
                    filled: true,
                    fillColor: bottomSheetBackgroundWidgetColor,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(42),
                  padding: EdgeInsets.zero,
                  backgroundColor: welcomeRegisterButtonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () async {
                  final String name = serverNameController.text;
                  ApiResponse apiResponse = await createServer(name);

                  if (apiResponse.isSuccess) {
                    if (!mounted) return;
                    Navigator.pop(context);

                    Fluttertoast.showToast(
                      msg: apiResponse.payload.message,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: signinLoginButtonColor,
                      textColor: whiteColor,
                    );

                    serverNameController.clear();
                  }
                },
                child: const Text('Tạo Máy Chủ'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showBottomSheetCreateChatChannel(BuildContext context, String serverId) {
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
            child: Column(children: [
              const Text(
                "Tạo Kênh Chat",
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
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: chatChannelNameController,
                  cursorColor: cursorColor,
                  style: const TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    hintText: "Nhập Tên Kênh Chat",
                    hintStyle: const TextStyle(
                        color: bottomSheetTextSecondaryColor, fontSize: 14),
                    filled: true,
                    fillColor: bottomSheetBackgroundWidgetColor,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(42),
                  padding: EdgeInsets.zero,
                  backgroundColor: welcomeRegisterButtonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () async {
                  final String name = chatChannelNameController.text;
                  ApiResponse apiResponse =
                      await createChatChannel(name, serverId);

                  if (apiResponse.isSuccess) {
                    if (!mounted) return;
                    Navigator.pop(context);

                    Fluttertoast.showToast(
                      msg: apiResponse.payload.message,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: signinLoginButtonColor,
                      textColor: whiteColor,
                    );

                    chatChannelNameController.clear();
                  }
                },
                child: const Text('Tạo Kênh Chat'),
              )
            ]));
      },
    );
  }

  void showBottomSheetInviteMemberToServer(
      BuildContext context, String serverId) {
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
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) => Container(
        width: screenSize.width,
        color: statusBarColor,
        child: SafeArea(
            child: Row(
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
                        itemCount: vm.me.servers.length + 1,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: index < vm.me.servers.length
                                ? GestureDetector(
                                    onTap: () {
                                      store.dispatch(SetSelectedServerAction(
                                          index: index));
                                    },
                                    child: StoreConnector<AppState, AppState>(
                                        converter: (store) => store.state,
                                        builder: (context, vm) => vm
                                                    .selectedServer ==
                                                index
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
                                                          color: statusBarColor,
                                                          shape:
                                                              BoxShape.circle),
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
                                              )),
                                  )
                                : RawMaterialButton(
                                    fillColor: channelBackgroundColor,
                                    elevation: 0,
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(12.0),
                                    onPressed: () =>
                                        showBottomSheetCreateServer(context),
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
                child: StoreConnector<AppState, AppState>(
                    converter: (store) => store.state,
                    builder: (context, vm) {
                      bool isAuthorized = vm.me.servers.isNotEmpty
                          ? vm.me.servers[vm.selectedServer].hostId == vm.me.id
                          : false;
                      return vm.selectedServer >= 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 20, 12, 12),
                                  child: Text(
                                    vm.me.servers[vm.selectedServer].name,
                                    style: const TextStyle(
                                        color: whiteColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                isAuthorized
                                    ? Padding(
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
                                          onPressed: () =>
                                              showBottomSheetInviteMemberToServer(
                                                  context,
                                                  vm
                                                      .me
                                                      .servers[
                                                          vm.selectedServer]
                                                      .id),
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
                                      )
                                    : Container(),
                                Column(
                                  children: [
                                    Theme(
                                      data: ThemeData().copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        backgroundColor: channelBackgroundColor,
                                        title: GroupChannelTitleWidget(
                                            isExpand: isExpandChatChannel,
                                            name: "KÊNH CHAT"),
                                        onExpansionChanged: (value) {
                                          setState(() {
                                            isExpandChatChannel = value;
                                          });
                                        },
                                        initiallyExpanded: true,
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        trailing: GestureDetector(
                                          onTap: isAuthorized
                                              ? () =>
                                                  showBottomSheetCreateChatChannel(
                                                      context,
                                                      vm
                                                          .me
                                                          .servers[
                                                              vm.selectedServer]
                                                          .id)
                                              : null,
                                          child: Icon(
                                            Icons.add,
                                            color: isAuthorized
                                                ? channelIconColor
                                                : Colors.transparent,
                                            size: 20,
                                          ),
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: vm
                                                .me
                                                .servers[vm.selectedServer]
                                                .chatChannels
                                                .length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return ChannelItemWidget(
                                                index: index,
                                                channel: vm
                                                    .me
                                                    .servers[vm.selectedServer]
                                                    .chatChannels[index],
                                                type: ChannelItemType.chat,
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const Center(
                              child: Text(
                                "Hãy Lựa Chọn Máy Chủ",
                                style: TextStyle(color: channelIconColor),
                              ),
                            );
                    }),
              ),
            )
          ],
        )),
      ),
    );
  }
}
