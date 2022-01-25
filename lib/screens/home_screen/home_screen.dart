import 'package:feex/auth/auth_functions.dart';
import 'package:feex/components/drawer.dart';
import 'package:feex/constants.dart';
import 'package:feex/profile/user_profile.dart';
import 'package:feex/providers/customer_details_provider.dart';
import 'package:feex/screens/all_services/all_services.dart';

import 'package:feex/screens/home_screen/top_services_widget.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CustomerDetailsProvider>(context, listen: false)
        .fetchCustomerDetails();
  }

  Widget customerDetailsHomeWidget(BuildContext context) {
    return Consumer<CustomerDetailsProvider>(builder: (context, value, child) {
      return value.isGuestUser == false && value.hasData == false
          ? const CircularProgressIndicator(
              color: kPrimaryColor,
              strokeWidth: 3.0,
            )
          : Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: ListTile(
                  title: value.isGuestUser == true
                      // if not a guest user then displays customers name
                      ? const Text(
                          'Welcome Guest',
                          style: TextStyle(color: kPrimaryColor, fontSize: 20),
                        ) // is a guest user
                      : Text(
                          value.customerDetailsModel
                              .name, // if not a guest displays name
                          style: TextStyle(color: kPrimaryColor, fontSize: 20),
                        ),
                  subtitle: const Text(
                    'How we can help you today? ',
                    style: TextStyle(color: kSecondaryColor),
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile())),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: skyBlueColor,
                    child: Image.asset('assets/images/user_default.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            customerDetailsHomeWidget(context),
            const TopCategoriesWidget(),
          ],
        )),
      ),
    );
  }

  Widget buildDrawer() => DrawerWidget();
}
