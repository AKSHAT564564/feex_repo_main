import 'package:feex/models/service_details_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//provider class for topcategories provider

class TopServicesProvider extends ChangeNotifier {
  
  List<ServiceDetailsDataModel> _topSerivcesData = []; // for data as list
  bool _error = false; // error handling
  String _errorMessage = ''; // error handling

  //getters for data
  List<ServiceDetailsDataModel> get topServicesData => _topSerivcesData;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  // Async Function for fetching...returns datatype of
  // List<TopCategoriesDataModel>

  fetchData() async {
    //Runs http request

    var response = await http.get(
      Uri.parse('https://feex.herokuapp.com/api/services/?top=True'),
    ); //fetches all the top services

    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body) as List;
        //converts data into a list for easy breakdown

        //Maps data as a list of data model
        _topSerivcesData = jsonResponse
            .map((e) => ServiceDetailsDataModel.fromJson(e))
            .toList();

        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _topSerivcesData = [];
      }
    } else {
      _error = true;
      _errorMessage = 'Unknown';
      _topSerivcesData = [];
    }
    notifyListeners();
  }

  void initialValues() {
    _topSerivcesData = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
