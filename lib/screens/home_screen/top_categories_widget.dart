import 'package:feex/constants.dart';
import 'package:feex/screens/all_services/all_services.dart';
import 'package:feex/screens/models/top_categories_datamodel.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopCategoriesWidget extends StatefulWidget {
  const TopCategoriesWidget({Key? key}) : super(key: key);

  @override
  _TopCategoriesWidgetState createState() => _TopCategoriesWidgetState();
}

class _TopCategoriesWidgetState extends State<TopCategoriesWidget> {
  Future<List<TopCategoriesDataModel>> fetchData() async {
    var token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjUyNjQ3MTA2LCJqdGkiOiJmNDc0ZDgyMzQ4MGU0YzQyOTNhODU5Y2ZlYmVhMDU5NCIsInVzZXJfaWQiOjN9.tHn6Qc8q6huJJdcERSPPu_X-fBgeTZ2Vp5Qc6p1n46k';
    try {
      var response = await http.get(
          Uri.parse('http://feex.herokuapp.com/api/categories/'),
          headers: {'Authorization': 'Bearer$token'});
      print(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;

        return jsonResponse
            .map((e) => TopCategoriesDataModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((value) => {print('abcd ${value.toString()}')});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Top Categories',
                  style: TextStyle(color: kPrimaryColor, fontSize: 20),
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
                    subtitle: const Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 2.0),
                      child: Text(
                        'Service Title',
                        style: TextStyle(color: kSecondaryColor, fontSize: 12),
                      ),
                    ),
                  );
                }),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllServices())),
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
    );
  }
}
