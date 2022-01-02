import 'package:feex/constants.dart';
import 'package:feex/screens/quotation_screens/quotation_details.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Widget bottomWidget() {
    return Container(
      height: SizeConfig.screenHeight * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25, left: 20, right: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plumber',
                            style: TextStyle(
                                fontSize: 18,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.asset(
                                    'assets/images/location_pin.png'),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Dubai -Silicon Oasis',
                                    style: TextStyle(color: kSecondaryColor),
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(color: kSecondaryColor),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/clock_icon.png',
                                scale: 1.5,
                              ),
                            ),
                            Text(
                              'Pending',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuotationDetails())),
                          child: const Text(
                            'View Quotation',
                            style: TextStyle(
                                color: greenColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ))
              ],
            ),
            const ListTile(
              title: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Estimated Time to Recieve the Service',
                  style: TextStyle(color: kSecondaryColor, fontSize: 15),
                ),
              ),
              subtitle: Text(
                '1hr & 30 Min',
                style: TextStyle(fontSize: 20, color: kSecondaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  orderItemWidget(status) {
    return GestureDetector(
      onTap: () => showBarModalBottomSheet(
          duration: const Duration(microseconds: 300),
          bounce: true,
          context: context,
          backgroundColor: Colors.white,
          builder: (context) {
            return bottomWidget();
          }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffe3def8), width: 1.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Plumber',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
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
                        Image.asset(
                          'assets/images/completed_icon.png',
                          scale: 3.5,
                        ),
                        Text(
                          '$status',
                          style: TextStyle(color: Colors.black),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: kSecondaryColor,
                        )
                      ],
                    ))
              ],
            )),
      ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Joseph Jo',
                            style: const TextStyle(
                                color: kPrimaryColor, fontSize: 20),
                          ),
                          Text(
                            'jsoeph@feexapp.com',
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
              height: SizeConfig.screenHeight * 0.04,
            ),
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                orderItemWidget('Pending'),
                orderItemWidget('Completed'),
                orderItemWidget('Cancelled')
              ],
            )
          ],
        ),
      ),
    );
  }
}
