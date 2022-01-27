import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/models/customer_address_model.dart';
import 'package:feex/profile/user_add_address.dart';
import 'package:feex/providers/customer_address_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class UserSavedAddress extends StatefulWidget {
  @override
  State<UserSavedAddress> createState() => _UserSavedAddressState();
}

class _UserSavedAddressState extends State<UserSavedAddress> {
  savedAddressWidget(CustomerAddressModel customerAddressModel) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserAddAddress(
                  isEditingAddress: true,
                  customerAddressModel: customerAddressModel))).then((value) {
        CustomerAddressProvider().fetchAllCustomerAddress();
        setState(() {});
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
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
              // Expanded(
              //     flex: 2,
              //     child: IconButton(
              //         onPressed: () async {

              //         },
              //         icon: const Icon(Icons.edit)))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CustomerAddressProvider>().fetchAllCustomerAddress();
    return Consumer<CustomerAddressProvider>(
        builder: (_, customerAddressValue, __) {
      // self explanatory conditional rendering
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserAddAddress()))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: customerAddressValue.guestUser
                      ? const Text('')
                      : const Text(
                          'Add',
                          style: TextStyle(color: greenColor),
                        ))
            ],
            elevation: 1,
            title: const Text(
              'Saved Addresses',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 30),
              child: customerAddressValue.guestUser == true
                  ? const Center(
                      child: DefaultButton(
                        text: 'Login to Continue',
                      ),
                    )
                  : customerAddressValue.hasAllAddress &&
                          customerAddressValue.error == false
                      ? ListView.builder(
                          itemCount:
                              customerAddressValue.customerAddresss.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return savedAddressWidget(
                                customerAddressValue.customerAddresss[index]);
                          })
                      : customerAddressValue.error == true
                          ? const Text('Error Loading Address')
                          : Text('Loading')));
    });
  }
}
