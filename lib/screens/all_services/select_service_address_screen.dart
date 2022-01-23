import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/models/customer_address_model.dart';
import 'package:feex/providers/customer_address_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectServiceAddress extends StatelessWidget {
  SelectServiceAddress({Key? key}) : super(key: key);

  String gValue = 'addressGroup';
  ValueNotifier<int> selectedAddressNotifier = ValueNotifier<int>(0);

  final _controller = ScrollController();

  savedAddressWidget(CustomerAddressModel customerAddressModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xffe3def8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<int>(
                valueListenable: selectedAddressNotifier,
                builder: (_, selectAddressValue, __) {
                  return Expanded(
                      flex: 1,
                      child: Radio<int>(
                          activeColor: kPrimaryColor,
                          value: customerAddressModel.id,
                          groupValue: selectAddressValue,
                          onChanged: (v) {
                            selectedAddressNotifier.value = v!;
                          }));
                }),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      customerAddressModel.type.toString().toUpperCase(),
                      style: const TextStyle(
                          fontSize: 17,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      customerAddressModel.floor.toString() +
                          ', ' +
                          customerAddressModel.buildingHouse.toString() +
                          ', ' +
                          customerAddressModel.name,
                    ),
                    Text(customerAddressModel.street +
                        ', ' +
                        customerAddressModel.area)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CustomerAddressProvider>().fetchCustomerAddress();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            )),
        // actions: [
        //   TextButton(
        //       onPressed: () {},
        //       child: const Text(
        //         'Add',
        //         style: TextStyle(color: greenColor),
        //       ))
        // ],
        elevation: 1,
        title: const Text(
          'Saved Addresses',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Confirm Address',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Consumer<CustomerAddressProvider>(
                  builder: (_, customerAddressValue, __) {
                // self explanatory conditional rendering
                return customerAddressValue.guestUser == true
                    ? const Text('Login to Continue')
                    : customerAddressValue.hasAddress &&
                            customerAddressValue.error == false
                        ? ListView.builder(
                            controller: _controller,
                            itemCount:
                                customerAddressValue.customerAddresss.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return savedAddressWidget(
                                  customerAddressValue.customerAddresss[index]);
                            })
                        : customerAddressValue.error == true
                            ? const Text('Error Loading Address')
                            : Text('Loading');
              }),
              DefaultButton(
                text: 'Request',
              )
            ],
          ),
        ),
      ),
    );
  }
}
