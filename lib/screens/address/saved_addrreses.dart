import 'package:feex/constants.dart';
import 'package:flutter/material.dart';

class SavedAddresses extends StatelessWidget {
  const SavedAddresses({Key? key}) : super(key: key);

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
      ),
    );
  }
}
