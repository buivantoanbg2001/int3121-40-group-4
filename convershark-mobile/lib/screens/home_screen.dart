import 'package:convershark/helpers/api/users.api.dart';
import 'package:convershark/models/user.model.dart';
import 'package:convershark/redux/actions.dart';
import 'package:convershark/redux/app_state.dart';
import 'package:convershark/screens/account_screen.dart';
import 'package:convershark/screens/channel_screen.dart';
import 'package:convershark/screens/friend_screen.dart';
import 'package:convershark/screens/notification_screen.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  late Future<UserModel> me;

  @override
  void initState() {
    super.initState();
    me = getMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    void onTabSelected(int index) {
      setState(() {
        _selectedTabIndex = index;
      });
    }

    return FutureBuilder<UserModel>(
      future: me,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              onInit: (store) {
                store.dispatch(SetMeAction(me: snapshot.data!));
              },
              builder: (context, vm) => Scaffold(
                    backgroundColor: statusBarColor,
                    body: _selectedTabIndex == 0
                        ? const ChannelScreen()
                        : _selectedTabIndex == 1
                            ? const FriendScreen()
                            : _selectedTabIndex == 2
                                ? const NotificationScreen()
                                : const AccountScreen(),
                    bottomNavigationBar: SizedBox(
                      height: 60,
                      child: BottomNavigationBar(
                        elevation: 0,
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: bottomNavigationColor,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        unselectedItemColor: unSelectedIconColor,
                        selectedItemColor: whiteColor,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Image.asset(
                              "assets/images/discord_icon_unselected.png",
                              height: 24,
                              width: 24,
                            ),
                            label: 'Home',
                            activeIcon: Image.asset(
                              "assets/images/discord_icon.png",
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.people),
                            label: 'Friends',
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.alternate_email),
                            label: 'Notifications',
                          ),
                          const BottomNavigationBarItem(
                            icon: Icon(Icons.emoji_emotions),
                            label: 'Account',
                          ),
                        ],
                        currentIndex: _selectedTabIndex,
                        onTap: onTabSelected,
                      ),
                    ),
                  ));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(
          child: CircularProgressIndicator(
            color: welcomeRegisterButtonColor,
          ),
        );
      },
    );
  }
}
