import 'package:feex/constants.dart';
import 'package:feex/screens/all_services/service_details.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllServices extends StatelessWidget {
  const AllServices({Key? key}) : super(key: key);

  scrollWidget(title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title.toString(),
                style: TextStyle(color: kPrimaryColor),
              ),
            )
          ],
        ),
        SizedBox(
          height: 140,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ServiceDetails()));
                          },
                          child: Hero(
                              tag: '$index' + '$title',
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Color(0xffE3DEF8), width: 1.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
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
                    ),
                    Text('title')
                  ],
                );
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
              )),
          title: const Text(
            'All Services',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              scrollWidget('Cleaning Services 1'),
              scrollWidget('Cleaning Services 2'),
              scrollWidget('Cleaning Services 3')
            ],
          ),
        ));
  }
}
