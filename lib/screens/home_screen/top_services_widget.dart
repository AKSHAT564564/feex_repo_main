import 'package:feex/constants.dart';
import 'package:feex/providers/top_services_provider.dart';
import 'package:feex/screens/all_services/all_services.dart';
import 'package:feex/screens/all_services/service_details.dart';

import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TopCategoriesWidget extends StatelessWidget {
  const TopCategoriesWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    //initiates data calling as soon as widget is about to be build

    context.read<TopServicesProvider>().fetchData();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 20),
                child: Text(
                  'Top Services',
                  style: TextStyle(color: kPrimaryColor, fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
              width: double.infinity,
              height: SizeConfig.screenHeight * 0.45,
              child: RefreshIndicator(
                onRefresh: () async {},

                // provider consumer for data and updates as soon as async call completes

                child: Consumer<TopServicesProvider>(
                    builder: (context, value, child) {
                  return value.topServicesData.isEmpty &&
                          !value.error // shows CPI when listening to data
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: kPrimaryColor,
                          strokeWidth: 3,
                        ))
                      : value.error
                          ? const Text('Something Wrong')
                          : Column(
                              children: [
                                GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  children: List.generate(
                                      value.topServicesData.length, (index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ServiceDetails(
                                                            serviceDetails:
                                                                //passing details of a particular service
                                                                value.topServicesData[
                                                                    index])));
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xffE3DEF8),
                                                    width: 1.0)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: const FadeInImage(
                                                placeholder: AssetImage(
                                                    'assets/images/frame_blue.png'),
                                                image: AssetImage(
                                                    'assets/images/frame_blue.png'),
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
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 2.0),
                                          child: Text(
                                            value.topServicesData[index]
                                                .serviceName,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: kSecondaryColor,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllServices())); // to notify that conumser
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'show all',
                                        style: TextStyle(
                                            color: greenColor, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                }),
              )),
        ],
      ),
    );
  }
}
