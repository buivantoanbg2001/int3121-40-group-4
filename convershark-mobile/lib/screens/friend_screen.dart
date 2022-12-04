import 'dart:convert';
import 'package:convershark/helpers/api/notifications.api.dart';
import 'package:convershark/models/api_response.model.dart';
import 'package:convershark/widgets/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreen();
}

class Friend {
  final String avatar;
  final String name;
  final String status;
  final String iconCall;
  final String iconMessage;

  Friend(this.avatar, this.name, this.status, this.iconCall, this.iconMessage);

  Friend.fromJson(Map<String, dynamic> json)
      : avatar = json['avatar'],
        name = json['name'],
        status = json['status'],
        iconCall = json['iconCall'],
        iconMessage = json['iconMessage'];
}

class _FriendScreen extends State<FriendScreen> {
  TextEditingController friendUidController = TextEditingController();

  List<Friend> friendList = (jsonDecode(
              '[{"avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","name":"akameneko","status":"online","iconCall":"Icon(MyFlutterApp.call)","iconMessage":"Icon(Icons.messenger)"},{"avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","name":"Nero","status":"online","iconCall":"Icon(MyFlutterApp.call)","iconMessage":"Icon(Icons.messenger)"},{"avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","name":"Rix","status":"offline","iconCall":"Icon(MyFlutterApp.call)","iconMessage":"Icon(Icons.messenger)"}]')
          as List)
      .map((item) => Friend.fromJson(item))
      .toList();

  List<Friend> friendListOnline = (jsonDecode(
              '[{"avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","name":"akameneko","status":"online","iconCall":"Icon(MyFlutterApp.call)","iconMessage":"Icon(Icons.messenger)"},{"avatar":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwCZE-3NGtzDSPHzbwo_9FyPvfkCwAVWbW6Q&usqp=CAU","name":"Nero","status":"online","iconCall":"Icon(MyFlutterApp.call)","iconMessage":"Icon(Icons.messenger)"}]')
          as List)
      .map((item) => Friend.fromJson(item))
      .toList();

  @override
  void dispose() {
    super.dispose();
    friendUidController.dispose();
  }

  void showBottomSheetAddFriend(BuildContext context) {
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
                "Thêm bạn bè trên Convershark",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Bạn cần phải có cả tên người dùng và số nhận diện của họ. Hãy nhớ rằng tên người dùng có phân biệt chữ in hoa và chữ thường.",
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
                  controller: friendUidController,
                  cursorColor: cursorColor,
                  style: const TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    hintText: "Tên người dùng#0000",
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
                  // final String uid = friendUidController.text;
                  // ApiResponse apiResponse =
                  //     await inviteFriend("638b95320daa8ec35d370593");

                  // if (apiResponse.isSuccess) {
                  //   if (!mounted) return;
                  //   Navigator.pop(context);

                  //   Fluttertoast.showToast(
                  //     msg: apiResponse.payload.message,
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: signinLoginButtonColor,
                  //     textColor: whiteColor,
                  //   );

                  //   friendUidController.clear();
                  // }
                },
                child: const Text('Gửi Yêu Cầu Kết Bạn'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: friendHeaderColor,
          shape: const Border(
              bottom: BorderSide(color: friendBorderColor, width: 0.5)),
          elevation: 0,
          title: const Text("Bạn bè", style: TextStyle(fontSize: 20)),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              onPressed: () => showBottomSheetAddFriend(context),
              icon: const Icon(
                Icons.person_add_alt_1,
                color: friendIconColor,
                size: 20,
              ),
            ),
          ],
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Container(
                color: friendBackgroundColor,
                width: screenSize.width,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  itemCount: friendList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox(
                          child: Column(children: <Widget>[
                        SizedBox(
                            child: Row(children: [
                          const SizedBox(width: 16),
                          Text(
                            "TRỰC TUYẾN - ${friendListOnline.length}",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: friendTextColor),
                          ),
                        ])),
                        FriendItemWidget(
                          avatar: friendList[index].avatar,
                          name: friendList[index].name,
                          status: friendList[index].status,
                        )
                      ]));
                    }
                    if (index == friendListOnline.length) {
                      return SizedBox(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            SizedBox(
                                child: Row(children: [
                              const SizedBox(width: 16),
                              Text(
                                "NGOẠI TUYẾN - ${friendList.length - friendListOnline.length}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: friendTextColor),
                              ),
                            ])),
                            FriendItemWidget(
                              avatar: friendList[index].avatar,
                              name: friendList[index].name,
                              status: friendList[index].status,
                            )
                          ]));
                    }
                    return FriendItemWidget(
                      avatar: friendList[index].avatar,
                      name: friendList[index].name,
                      status: friendList[index].status,
                    );
                  },
                )),
          ),
        ]));
  }
}
