import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text1,
    this.text2,
    this.image,
  }) : super(key: key);
  final String? text1,text2, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(290),
          width: getProportionateScreenWidth(250),
        ),
        Spacer(flex: 2),
        Text(
          text1!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          text2!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
      ],
    );
  }
}