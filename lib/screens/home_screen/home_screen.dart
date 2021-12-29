import 'package:feex/components/drawer.dart';
import 'package:feex/constants.dart';
import 'package:feex/screens/all_services/all_services.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: skyBlueColor,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: ListTile(
                      title: Text(
                        'Hi Joseph',
                        style: TextStyle(color: kPrimaryColor, fontSize: 20),
                      ),
                      subtitle: Text(
                        'How we can help you today?',
                        style: TextStyle(color: kSecondaryColor),
                      ))),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Top Categories',
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: SizeConfig.screenHeight * 0.38,
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          children: List.generate(6, (index) {
                            return ListTile(
                              title: Padding(
                                padding: EdgeInsets.zero,
                                child: GestureDetector(
                                  onTap: null,
                                  child: Hero(
                                      tag: '$index',
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Color(0xffE3DEF8),
                                                width: 1.0)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: const FadeInImage(
                                            placeholder: AssetImage(
                                                'assets/images/frame_blue.png'),
                                            image: AssetImage(
                                                'assets/images/frame_blue.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              subtitle: const Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 2.0),
                                child: Text(
                                  'Service Title',
                                  style: TextStyle(
                                      color: kSecondaryColor, fontSize: 12),
                                ),
                              ),
                            );
                          }),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllServices())),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'show all',
                              style: TextStyle(color: greenColor, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget buildDrawer() => DrawerWidget();
}
