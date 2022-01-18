import 'package:feex/constants.dart';
import 'package:feex/models/top_categories_datamodel.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:feex/screens/all_services/all_services_scroll_widget.dart';
import 'package:feex/screens/all_services/service_details.dart';
import 'package:feex/screens/all_services/service_details_two.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AllServices extends StatefulWidget {
  List<TopCategoriesDataModel> servicesData;
  AllServices({required this.servicesData});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
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
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: ListView.builder(
                itemCount: widget.servicesData.length,
                itemBuilder: (BuildContext context, int index) {
                  return AllServicesScrollWidget(
                      categoryId: widget.servicesData[index].id,
                      categoryName: widget.servicesData[index].Category);
                })));
  }
}
