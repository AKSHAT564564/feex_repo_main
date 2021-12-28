import 'package:feex/components/default_button.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'splash_components.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text1": "Welcome",
      "text2": "on-boarding text 1",
      "image": "assets/images/splash1.jpg"
    },
    {
      "text1": "dummy text p1",
      "text2": "on-boarding text 2",
      "image": "assets/images/splash1.jpg"
    },
    {
      "text1": "dummy text p2",
      "text2": "on-boarding text 3",
      "image": "assets/images/splash1.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text1: splashData[index]['text1'],
                    text2: splashData[index]['text2'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(flex: 3),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, LoginScreen.routeName),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 17.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff211452),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff211452),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 8 : 5,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
