import 'package:feex/constants.dart';
import 'package:feex/models/service_details_data_model.dart';
import 'package:feex/providers/all_categories_provider.dart';
import 'package:feex/screens/all_services/all_services_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AllServices extends StatefulWidget {
  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AllCategoriesAndServiceProvider>(context, listen: false)
        .fetchAllCategories();
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
        body:
            Consumer<AllCategoriesAndServiceProvider>(builder: (_, value, __) {
          return value.hasData == false
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        strokeWidth: 2,
                        color: kPrimaryColor,
                      ),
                      Text(
                        ' Loading... ',
                        style: TextStyle(color: kSecondaryColor, fontSize: 25),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: value.categoriesData.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var categoryId = value.categoriesData[index].id;
                    String categoryName = value.categoriesData[index].Category;
                    List<ServiceDetailsDataModel> serviceDeatils =
                        value.categoriesServiceDataMap[categoryId.toString()];
                    return AllServicesScrollWidget(
                        serviceDetails: serviceDeatils,
                        categoryName: categoryName);
                  });
        }));
  }
}
