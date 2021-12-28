import 'package:feex/components/drawer.dart';
import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: skyBlueColor,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Hi Josheph",
                style: TextStyle(fontSize: 20, color: kPrimaryColor),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget buildDrawer() => DrawerWidget();
}
