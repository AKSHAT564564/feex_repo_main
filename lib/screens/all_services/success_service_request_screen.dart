import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessFullServiceRequest extends StatelessWidget {
  const SuccessFullServiceRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SvgPicture.asset('assets/images/check_icon.svg'),
                  Image.asset('assets/images/check_icon_dots.png')
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              const Text(
                'Thank You',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              const Text(
                'Your request details will be sent to your service account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: getProportionateScreenHeight(150),
              ),
              DefaultButton(
                text: 'ok',
                press: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
