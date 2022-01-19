import 'package:feex/constants.dart';
import 'package:feex/models/service_details_data_model.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:feex/screens/all_services/service_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllServicesScrollWidget extends StatefulWidget {
  String categoryName;
  List<ServiceDetailsDataModel> serviceDetails;
  AllServicesScrollWidget(
      {required this.categoryName, required this.serviceDetails});

  @override
  _AllServicesScrollWidgetState createState() =>
      _AllServicesScrollWidgetState();
}

class _AllServicesScrollWidgetState extends State<AllServicesScrollWidget> {
  // initializing the data type of service details array
  bool noData = false; // for empty array case

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
              child: Text(
                widget.categoryName.toString(),
                style: const TextStyle(color: kSecondaryColor),
              ),
            )
          ],
        ),
        SizedBox(
          height: 120,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.serviceDetails.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServiceDetails(
                                    serviceDetails:
                                        widget.serviceDetails[index],
                                  )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: null,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xffE3DEF8), width: 1.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: const FadeInImage(
                                placeholder:
                                    AssetImage('assets/images/frame_blue.png'),
                                image:
                                    AssetImage('assets/images/frame_blue.png'),
                                // image: NetworkImage(
                                //     'https://feex.herokuapp.com' +
                                //         value
                                //             .topServicesData[
                                //                 index]
                                //             .iconUrl),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 2.0),
                          child: Text(
                            widget.serviceDetails[index].serviceName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: kSecondaryColor, fontSize: 12),
                          ),
                        )
                      ],
                    ));
              }),
        )
      ],
    );
  }
}
