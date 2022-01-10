import 'package:feex/models/top_categories_datamodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//provider class for topcategories provider

class TopCategoriesProvider extends ChangeNotifier {
  List<TopCategoriesDataModel> _topCategoriesData = []; // for data as list
  bool _error = false; // error handling
  String _errorMessage = ''; // error handling

  //getters for data

  List<TopCategoriesDataModel> get topCategoriesData => _topCategoriesData;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  // Async Function for fetching...returns datatype of
  // List<TopCategoriesDataModel>

  fetchData() async {
    var token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjUyNjQ3MTA2LCJqdGkiOiJmNDc0ZDgyMzQ4MGU0YzQyOTNhODU5Y2ZlYmVhMDU5NCIsInVzZXJfaWQiOjN9.tHn6Qc8q6huJJdcERSPPu_X-fBgeTZ2Vp5Qc6p1n46k';

    //Runs http request

    var response = await http.get(
        Uri.parse('http://feex.herokuapp.com/api/categories/'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body) as List;
        // coverts data into a list for easy breakdown

        //Maps data as a list of data model
        _topCategoriesData = jsonResponse
            .map((e) => TopCategoriesDataModel.fromJson(e))
            .toList();
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _topCategoriesData = [];
      }
    } else {
      _error = true;
      _errorMessage = 'Unknown';
      _topCategoriesData = [];
    }
    notifyListeners();
  }

  void initialValues() {
    _topCategoriesData = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
