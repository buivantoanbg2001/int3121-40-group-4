import 'package:convershark/screens/account/account_screen.dart';
import 'package:convershark/screens/channel/channel_screen.dart';
import 'package:convershark/screens/chat/chat_screen.dart';
import 'package:convershark/screens/friend/friend_screen.dart';
import 'package:convershark/screens/notification/notification_screen.dart';
import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/helpers/overlapping_panels.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool _isHideBottomNavigation = true;
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    void onTabSelected(int index) {
      if (index == 0) {
        setState(() {
          _isHideBottomNavigation = true;
        });
      }

      if (index != 2) {
        setState(() {
          _selectedTabIndex = index;
        });
      } else {
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
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  // controller: usernameController,
                  cursorColor: cursorColor,
                  style: const TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    hintText: "Bạn muốn đến đâu?",
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
                    suffixIcon: IconButton(
                      icon:
                          const Icon(Icons.search, color: bottomSheetIconColor),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: statusBarColor,
      body: _selectedTabIndex == 0
          ? OverlappingPanels(
              left: Builder(builder: (context) {
                return const ChannelScreen();
              }),
              main: Builder(
                builder: (context) {
                  return const ChatScreen();
                },
              ),
              onSideChange: (side) {
                setState(() {
                  if (side == RevealSide.main) {
                    _isHideBottomNavigation = true;
                  } else if (side == RevealSide.left) {
                    _isHideBottomNavigation = false;
                  }
                });
              },
            )
          : _selectedTabIndex == 1
              ? const FriendScreen()
              : _selectedTabIndex == 2
                  ? const Text('Search Screen')
                  : _selectedTabIndex == 3
                      ? const NotificationScreen()
                      : const AccountScreen(),
      bottomNavigationBar: SizedBox(
        height: _isHideBottomNavigation ? 0 : 60,
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
              icon: Icon(Icons.search),
              label: 'Search',
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
    );
  }
}
