import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/models/requested_service_data_model.dart';
import 'package:feex/providers/customer_address_provider.dart';
import 'package:feex/providers/customer_details_provider.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:feex/screens/quotation_screens/quotation_details.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';


class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Widget bottomWidget(RequestedServiceDataModel requestedServiceDataModel,
      BuildContext context) {
    //fetching all details of the rewuested service address
    //based on its id
    context.read<CustomerAddressProvider>().fetchAddressFromAddressId(
        requestedServiceDataModel.customerAddressModel.id);
    return SizedBox(
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
                            requestedServiceDataModel.serviceModel.name,
                            style: const TextStyle(
                                fontSize: 18,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.asset(
                                    'assets/images/location_pin.png'),
                              ),
                              Consumer<CustomerAddressProvider>(
                                  builder: (_, customerAddressValue, __) {
                                return customerAddressValue.hasAddress == false
                                    ? const Text('Loading')
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            customerAddressValue
                                                    .customerAddressModel!.floor
                                                    .toString() +
                                                ', ' +
                                                customerAddressValue
                                                    .customerAddressModel!
                                                    .street,
                                            style: const TextStyle(
                                                color: kSecondaryColor),
                                          ),
                                          Text(
                                            customerAddressValue
                                                .customerAddressModel!.type
                                                .toString()
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                color: kSecondaryColor),
                                          ),
                                        ],
                                      );
                              })
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
                              requestedServiceDataModel.status,
                              style: const TextStyle(color: kPrimaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<CustomerAddressProvider>(
                            builder: (_, value, __) {
                          return GestureDetector(
                            onTap: () {
                              if (value.hasAddress == false) {
                                return;
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuotationDetails(
                                            requestedServiceDataModel:
                                                requestedServiceDataModel,
                                            customerAddressModel:
                                                value.customerAddressModel!)));
                              }
                            },
                            child: const Text(
                              'View Quotation',
                              style: TextStyle(
                                  color: greenColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        })
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

  orderItemWidget(RequestedServiceDataModel requestedServiceDataModel) {
    return GestureDetector(
      onTap: () => showBarModalBottomSheet(
          duration: const Duration(microseconds: 300),
          bounce: true,
          context: context,
          backgroundColor: Colors.white,
          builder: (context) {
            return bottomWidget(requestedServiceDataModel, context);
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
                        children: [
                          Text(
                            requestedServiceDataModel.serviceModel.name,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Requested for : ${requestedServiceDataModel.customerAddressModel.name}',
                          ),
                          Text('Date: ${requestedServiceDataModel.date}')
                        ],
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Image.asset(
                            'assets/images/clock_icon.png',
                            scale: 1.5,
                            // scale: icon != 'assets/images/clock_icon.png'
                            //     ? 3.5
                            //     : 1.5,
                          ),
                        ),
                        Text(
                          requestedServiceDataModel.status,
                          style: const TextStyle(color: Colors.black),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ServiceDetailProvider>(context, listen: false)
        .getAllReuestedServiced();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<CustomerDetailsProvider>(
        builder: (_, customerDetailsValue, __) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
                            child:
                                Image.asset('assets/images/user_default.png'),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customerDetailsValue.customerDetailsModel.name,
                              style: const TextStyle(
                                  color: kPrimaryColor, fontSize: 20),
                            ),
                            Text(
                              customerDetailsValue.customerDetailsModel.email,
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
              customerDetailsValue.isGuestUser == true
                  ? const DefaultButton(
                      text: 'Login to Continue',
                    )
                  : Consumer<ServiceDetailProvider>(
                      builder: (_, allRequestedServiceValue, __) {
                      return allRequestedServiceValue.hasAllRequestedServices ==
                              false
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              itemCount: allRequestedServiceValue
                                  .allRequestedServices.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return orderItemWidget(allRequestedServiceValue
                                    .allRequestedServices[index]);
                              });
                    })
              // ListView.bu(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.vertical,
              //   physics: const BouncingScrollPhysics(),
              //   children: [
              //     orderItemWidget('Pending', kPendingIcon, 'Plumber'),
              //     orderItemWidget('Completed', kCompletedIcon, 'Carpenter'),
              //     orderItemWidget('Cancelled', kCancelledIcon, 'Ac Repair')
              //   ],
              // )
            ],
          ),
        ),
      );
    }));
  }
}
