import 'package:feex/constants.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  var email="joseph@gmail.com";
  var name= "Joseph Jo";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildDrawerItems(context),
        ],
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    return Container(
      color: Colors.white,
      height: SizeConfig.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Container(
              height: SizeConfig.screenHeight * 0.09,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: skyBlueColor,
                  // backgroundImage: NetworkImage(userAvatarUrl),
                ),
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.09,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Text(
                    "$email",
                    style: TextStyle(
                      fontSize: 20,
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.2,
              ),
              Icon(
                Icons.settings,
                color: kPrimaryColor,
                size: 36.0,
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {

                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(
                    "My orders",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(
                    "Notification",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(
                    "Get support",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(
                    "About",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(
                    "Payment Methods",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
