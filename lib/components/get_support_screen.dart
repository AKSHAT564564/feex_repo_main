import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: kPrimaryColor,
            )),
        title: null,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/frame_blue.png',
                height: SizeConfig.screenHeight * 0.08,
                width: SizeConfig.screenWidth * 0.4,
              ),
              SizedBox(
                height: getProportionateScreenHeight(50),
              ),
              const Text(
                'Need Some Help?',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              const Text(
                'if you have any queries or any complains \n regarding one of our services or you are facing \n technical issues please contact us through the \n following channels.',
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const Text(
                'Email: support@feex.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const Text(
                'Phone: +971 50 123 4567',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
