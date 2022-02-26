import 'package:feex/components/about.dart';
import 'package:feex/components/get_support_screen.dart';
import 'package:feex/constants.dart';
import 'package:feex/models/customer_detail_model.dart';
import 'package:feex/providers/customer_details_provider.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:feex/screens/my_orders/my_orders_screen.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    context.read<CustomerDetailsProvider>().fetchCustomerDetails();
    return SingleChildScrollView(child:
        Consumer<CustomerDetailsProvider>(builder: (context, value, child) {
      return Column(
        children: [
          buildDrawerItems(
              context, value.isGuestUser, value.customerDetailsModel),
        ],
      );
    }));
  }

  Widget customerDetailsDrawerWidget(BuildContext context, isGuestUser,
      CustomerDetailsModel customerDetailsModel) {
    return Row(
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
          children: [
            isGuestUser
                ? const Text(
                    'Guest',
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  )
                : Text(
                    customerDetailsModel.name,
                    style: const TextStyle(color: kPrimaryColor, fontSize: 20),
                  ),
            Text(
              customerDetailsModel.email,
              style: const TextStyle(color: kSecondaryColor, fontSize: 15),
            )
          ],
        )
      ],
    );
  }

  Widget buildDrawerItems(BuildContext context, isGuestUser,
      CustomerDetailsModel customerDetailsModel) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: customerDetailsDrawerWidget(
                      context, isGuestUser, customerDetailsModel)),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.07,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Home",
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
              Divider(),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyOrders())),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "My Orders",
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
              Divider(),
              InkWell(
                onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Notifications",
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
              Divider(),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetSupport())),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Get Support",
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
              Divider(),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage())),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "About",
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
              const Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Payment Methods",
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
              const Divider(),
              isGuestUser == true
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const TextButton(
                          onPressed: null,
                          child: Text(
                            'Login to Continue',
                            style: TextStyle(color: greenColor, fontSize: 20),
                          )),
                    )
                  : const Center()
            ],
          )
        ],
      ),
    );
  }
}
