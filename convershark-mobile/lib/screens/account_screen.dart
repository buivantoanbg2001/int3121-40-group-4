import 'package:convershark/helpers/constains/colors.dart';
import 'package:convershark/redux/app_state.dart';
import 'package:convershark/screens/welcome_screen.dart';
import 'package:convershark/widgets/account_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';

final storageBox = Hive.box("storageBox");

class AccountItem {
  final IconData iconData;
  final String name;
  final bool isHasChevron;
  final VoidCallback onTap;
  final List<Widget> actions;

  AccountItem(
      this.iconData, this.name, this.isHasChevron, this.onTap, this.actions);
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    void showToast(String msg) {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
      );
    }

    List<AccountItem> accountItemList = [
      AccountItem(Icons.account_box, "Tài Khoản Người Dùng", true,
          () => showToast("Tài Khoản Người Dùng"), []),
      AccountItem(Icons.output, "Đăng xuất", false, () {
        storageBox.delete("accessToken");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      }, [])
    ];

    return Scaffold(
      body: Container(
        color: statusBarColor,
        child: SafeArea(
            child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, vm) => Stack(children: <Widget>[
            Column(
              children: [
                Image.network(
                  vm.me.wallpaper,
                  height: 110,
                  width: screenSize.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: blackColor,
                  height: 90,
                ),
                Expanded(
                    child: Container(
                        color: accountBackgroundColor,
                        width: screenSize.width,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 12),
                            itemCount: accountItemList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return AccountItemWidget(
                                  iconData: accountItemList[index].iconData,
                                  name: accountItemList[index].name,
                                  isHasChevron:
                                      accountItemList[index].isHasChevron,
                                  onTap: accountItemList[index].onTap,
                                  actions: accountItemList[index].actions);
                            }))),
              ],
            ),
            Positioned(
              left: 16,
              top: 110 - 45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: blackColor,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(vm.me.avatar),
                      radius: 39,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: <Widget>[
                      Text(
                        vm.me.name,
                        style: const TextStyle(
                            color: whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "#${vm.me.uid.split("#").last}",
                        style: const TextStyle(
                          color: accountSecondaryTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
