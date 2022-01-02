import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class QuotationDetails extends StatelessWidget {
  const QuotationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            )),
        title: const Text(
          'Quotation Details',
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: [
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
      body: Column(
        children: [
          Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Dubai -Silicon Oasis',
                                          style:
                                              TextStyle(color: kSecondaryColor),
                                        ),
                                        Text(
                                          'Home',
                                          style:
                                              TextStyle(color: kSecondaryColor),
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
                                        builder: (context) =>
                                            QuotationDetails())),
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
          ),
          const Divider(
            height: 20,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
            color: kSecondaryColor,
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Quotation From Service Provider',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: SizeConfig.screenHeight * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0, color: Color(0xffe3def8))),
            ),
          )
        ],
      ),
    );
  }
}
