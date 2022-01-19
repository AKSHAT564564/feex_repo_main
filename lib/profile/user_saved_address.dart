import 'package:feex/constants.dart';
import 'package:feex/models/customer_address_model.dart';
import 'package:feex/providers/customer_address_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSavedAddress extends StatelessWidget {
  savedAddressWidget(CustomerAddressModel customerAddressModel) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xffe3def8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 6, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    customerAddressModel.type,
                    style: const TextStyle(
                        fontSize: 17,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Dubai -Silicon Oasis',
                  ),
                  const Text('Axis 3 Building')
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: const IconButton(onPressed: null, icon: Icon(Icons.edit)))
        ],
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
          elevation: 1,
          title: const Text(
            'Saved Addresses',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 25, left: 20, right: 30),
          child: Consumer<CustomerAddressProvider>(
              builder: (_, customerAddressValue, __) {
            // self explanatory conditional rendering
            return customerAddressValue.guestUser == true
                ? const Text('Login to Continue')
                : customerAddressValue.hasAddress &&
                        customerAddressValue.error == false
                    ? ListView.builder(
                        itemCount: customerAddressValue.customerAddresss.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return savedAddressWidget(
                              customerAddressValue.customerAddresss[index]);
                        })
                    : const Text('Error Loading Address');
          }),
        ));
  }
}
