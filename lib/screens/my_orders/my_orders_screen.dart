import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  orderItemWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xffe3def8), width: 1.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plumber',
                          style: TextStyle(
                              fontSize: 20,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Requested for : Home',
                        ),
                        Text('Date : 12/07/2020')
                      ],
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Icon(Icons.timer),
                      Text('Pedning'),
                      Icon(Icons.arrow_right)
                    ],
                  ))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
                        children: [
                          Text(
                            'Joseph Jo',
                            style: const TextStyle(
                                color: kPrimaryColor, fontSize: 20),
                          ),
                          Text(
                            'email',
                            style: const TextStyle(
                                color: kSecondaryColor, fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.settings_outlined,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.07,
            ),
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                orderItemWidget(),
                orderItemWidget(),
                orderItemWidget()
              ],
            )
          ],
        ),
      ),
    );
  }
}
