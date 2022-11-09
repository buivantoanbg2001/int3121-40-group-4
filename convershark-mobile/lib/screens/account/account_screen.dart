import 'package:app/utils/colors.dart';
import 'package:app/widgets/account_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      AccountItem(Icons.manage_accounts, "Cài đặt trạng thái", true,
          () => showToast("Cài đặt trạng thái"), []),
      AccountItem(Icons.account_box, "Tài khoản", true,
          () => showToast("Tài khoản"), []),
      AccountItem(Icons.edit, "Hồ sơ người dùng", true,
          () => showToast("Hồ sơ người dùng"), []),
      AccountItem(
          Icons.output, "Đăng xuất", false, () => showToast("Đăng xuất"), [])
    ];

    return Scaffold(
      body: Container(
        color: statusBarColor,
        child: SafeArea(
          child: Stack(children: <Widget>[
            Column(
              children: [
                Image.asset(
                  "assets/images/wallpaper.jpg",
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
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: blackColor,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: 39,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: const <Widget>[
                      Text(
                        "OMan",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "#2307",
                        style: TextStyle(
                          color: accountSecondaryTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
