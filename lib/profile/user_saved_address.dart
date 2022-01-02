import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class UserSavedAddress extends StatelessWidget {
  const UserSavedAddress({Key? key}) : super(key: key);

  savedAddressWidget(category) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xffe3def8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Expanded(
              flex: 1,
              child: Radio(
                  value: 'value', groupValue: 'groupValue', onChanged: null),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$category',
                    style: TextStyle(
                        fontSize: 17,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Dubai -Silicon Oasis',
                  ),
                  Text('Axis 3 Building')
                ],
              ),
            ),
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.edit))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            savedAddressWidget('Home'),
            SizedBox(height: getProportionateScreenHeight(14)),
            savedAddressWidget('Office'),
          ],
        ),
      ),
    );
  }
}
