import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/models/customer_address_model.dart';
import 'package:feex/models/requested_service_data_model.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuotationDetails extends StatefulWidget {
  RequestedServiceDataModel requestedServiceDataModel;
  CustomerAddressModel customerAddressModel;

  QuotationDetails(
      {required this.requestedServiceDataModel,
      required this.customerAddressModel,
      Key? key})
      : super(key: key);

  @override
  State<QuotationDetails> createState() => _QuotationDetailsState();
}

class _QuotationDetailsState extends State<QuotationDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ServiceDetailProvider>(context, listen: false)
        .getQuotationDetails(1);
  }

  final _scrollController = ScrollController();

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
          'Quotation Details',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.requestedServiceDataModel
                                        .serviceModel.name,
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
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Image.asset(
                                            'assets/images/location_pin.png'),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.requestedServiceDataModel
                                                .customerAddressModel.name,
                                            style: const TextStyle(
                                                color: kSecondaryColor),
                                          ),
                                          Text(
                                            widget.customerAddressModel.type,
                                            style: const TextStyle(
                                                color: kSecondaryColor),
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
                                      widget.requestedServiceDataModel.status,
                                      style:
                                          const TextStyle(color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ))
                      ],
                    ),
                    const ListTile(
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Estimated Time to Recieve the Service',
                          style:
                              TextStyle(color: kSecondaryColor, fontSize: 15),
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
            Consumer<ServiceDetailProvider>(builder: (_, quotationValue, __) {
              return quotationValue.hasQuotationData == false
                  //loading widget
                  ? const Padding(
                      padding: EdgeInsets.only(
                        left: 60,
                        right: 20,
                        top: 50,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: kPrimaryColor,
                          ),
                          title: Text('Loading...'),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1.0, color: Color(0xffe3def8))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Solution Includes',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                                controller: _scrollController,
                                itemCount: quotationValue
                                    .quotattionDataModel!.solution.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(quotationValue
                                      .quotattionDataModel!.solution[index]);
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Comment:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              quotationValue.quotattionDataModel!.comment
                                  .toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Price : ${quotationValue.quotattionDataModel!.price}',
                                  style: const TextStyle(color: kPrimaryColor),
                                ))
                          ],
                        ),
                      ),
                    );
            }),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ), 
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: DefaultButton(
                text: 'Accept',
                press: () {},
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff9A0E0E))),
                child: const TextButton(
                  child: Text(
                    'Decline',
                    style: TextStyle(fontSize: 20, color: Color(0xff9A0E0E)),
                  ),
                  onPressed: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
