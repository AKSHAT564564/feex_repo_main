import 'package:feex/constants.dart';
import 'package:feex/profile/user_account_info.dart';
import 'package:feex/profile/user_change_email.dart';
import 'package:feex/profile/user_change_password.dart';
import 'package:feex/profile/user_saved_address.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  Widget divider = const Divider(
    height: 20,
    thickness: 0.3,
    indent: 20,
    endIndent: 0,
    color: kSecondaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            )),
        title: const Text(
          'My Account',
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: const [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: null,
                child: Text(
                  'Edit',
                  style: TextStyle(color: greenColor),
                )),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Container(
                height: SizeConfig.screenHeight * 0.04,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 15),
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/user_default.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Jsoseph Jo',
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 20),
                          ),
                          Text(
                            'Welcome in Feex',
                            style:
                                TextStyle(color: kSecondaryColor, fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserAccountInfo()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Account Info",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kSecondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                divider,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSavedAddress()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Saved Addresses",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kSecondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                divider,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Saved Cards",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kSecondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                divider,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserChangeEmail()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Change Email",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kSecondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                divider,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserChangePassword()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Change Password",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: kSecondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                divider,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Log Out",
                          style: TextStyle(fontSize: 20, color: greenColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
