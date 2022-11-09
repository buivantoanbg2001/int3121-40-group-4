import 'package:app/screens/account/account_screen.dart';
import 'package:app/screens/channel/channel_screen.dart';
import 'package:app/screens/chat/chat_screen.dart';
import 'package:app/screens/friend/friend_screen.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/overlapping_panels.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool isHideBottomNavigation = true;
  int selectedTabIndex = 0;

  void onTabSelected(int index) {
    setState(() {
      if (index == 0) {
        isHideBottomNavigation = true;
      }
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackgroundColor,
      body: selectedTabIndex == 0
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
                    isHideBottomNavigation = true;
                  } else if (side == RevealSide.left) {
                    isHideBottomNavigation = false;
                  }
                });
              },
            )
          : selectedTabIndex == 1
              ? const FriendScreen()
              : selectedTabIndex == 2
                  ? const Text('Search Screen')
                  : selectedTabIndex == 3
                      ? const Text('Notifications Screen')
                      : const AccountScreen(),
      bottomNavigationBar: SizedBox(
        height: isHideBottomNavigation ? 0 : 56,
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
          currentIndex: selectedTabIndex,
          onTap: onTabSelected,
        ),
      ),
    );
  }
}
