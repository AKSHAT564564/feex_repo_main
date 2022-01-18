import 'package:feex/constants.dart';
import 'package:feex/models/service_details_data_model.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:feex/screens/all_services/service_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllServicesScrollWidget extends StatefulWidget {
  String categoryName;
  var categoryId;
  AllServicesScrollWidget(
      {required this.categoryId, required this.categoryName});

  @override
  _AllServicesScrollWidgetState createState() =>
      _AllServicesScrollWidgetState();
}

class _AllServicesScrollWidgetState extends State<AllServicesScrollWidget> {
  List<ServiceDetailsDataModel> _serviceDetails =
      []; // initializing the data type of service details array
  bool noData = false; // for empty array case

  final ServiceDetailProvider serviceDetailProvider = ServiceDetailProvider();

  @override
  void initState() {
    super.initState();

    ServiceDetailProvider().fetchAllServices(widget.categoryId).then((v) {
      setState(() {
        _serviceDetails = v;
        if (_serviceDetails.length == 0)
          noData = true; //checking if the Category has data or not
      });
    });
  }

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
        _serviceDetails.isEmpty && noData == false
            ? const CircularProgressIndicator(
                color: kPrimaryColor,
              )
            : SizedBox(
                height: 120,
                width: double.infinity,
                child: noData == true
                    ? const Text(
                        'Coming Soon',
                        style: TextStyle(color: kPrimaryColor),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _serviceDetails.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceDetails()));
                                },
                                child: SizedBox(
                                  height: 120,
                                  width: 100,
                                  child: ListTile(
                                    title: GestureDetector(
                                      onTap: null,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 2.0),
                                      child: Text(
                                        _serviceDetails[index].serviceName,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
              )
      ],
    );
  }
}
