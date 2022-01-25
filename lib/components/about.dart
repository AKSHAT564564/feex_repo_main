import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_sharp)),
        title: null,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/frame_blue.png',
              height: SizeConfig.screenHeight * 0.08,
              width: SizeConfig.screenWidth * 0.4,
            ),
            const Text(
              'Version: 1.0.1',
              style: TextStyle(color: kSecondaryColor, fontSize: 15),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            const Text(
              'About Us',
              style: TextStyle(color: kPrimaryColor, fontSize: 20),
            ),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry 45s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
              textAlign: TextAlign.start,
              maxLines: 5,
              style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            const Text(
              'Mission & Vision',
              style: TextStyle(color: kPrimaryColor, fontSize: 20),
            ),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry 45s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
              textAlign: TextAlign.start,
              maxLines: 5,
              style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
