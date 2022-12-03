import 'dart:convert';
import 'package:convershark/widgets/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:convershark/helpers/constains/colors.dart';

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
              onPressed: () {},
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
                          iconCall: friendList[index].iconCall,
                          iconMessage: friendList[index].iconMessage,
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
                              iconCall: friendList[index].iconCall,
                              iconMessage: friendList[index].iconMessage,
                            )
                          ]));
                    }
                    return FriendItemWidget(
                      avatar: friendList[index].avatar,
                      name: friendList[index].name,
                      status: friendList[index].status,
                      iconCall: friendList[index].iconCall,
                      iconMessage: friendList[index].iconMessage,
                    );
                  },
                )),
          ),
        ]));
  }
}
