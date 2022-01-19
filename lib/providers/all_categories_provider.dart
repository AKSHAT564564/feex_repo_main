import 'package:feex/models/top_categories_datamodel.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

// for the All Services page

class AllCategoriesAndServiceProvider extends ChangeNotifier {
  List<CategoriesDataModel> _categoriesData = [];
  Map<String, dynamic> _categoriesServiceDataMap = {};
  bool _error = false;
  String _errorMessage = '';
  bool _hasData = false;

  List<CategoriesDataModel> get categoriesData => _categoriesData;

  Map<String, dynamic> get categoriesServiceDataMap =>
      _categoriesServiceDataMap;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get hasData => _hasData;

  fetchAllCategories() async {
    String categoryUrl = 'https://feex.herokuapp.com/api/categories/';

    var response = await http.get(Uri.parse(categoryUrl));
    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body) as List;

        _categoriesData = await jsonResponse
            .map((e) => CategoriesDataModel.fromJson(e))
            .toList();

        for (var item in _categoriesData) {
          var categoryId = item.id;
          await ServiceDetailProvider()
              .fetchAllServices(
                  categoryId) //fetching service details for a category from a service detail provider
              // which returns a List of ServiceDetailsDataModel
              //Then we store it in a Map paired with the category id which is unique

              .then((serviceData) {
            _categoriesServiceDataMap[categoryId.toString()] = serviceData;
          });
        }

        _error = false;
        _errorMessage = '';
        _hasData = true;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _categoriesData = [];
        _categoriesServiceDataMap = {};
        _hasData = false;
      }
    } else {
      _error = true;
      _errorMessage = '';
      _categoriesData = [];
      _categoriesServiceDataMap = {};
      _hasData = false;
    }

    notifyListeners(); // fetching all categories
  }
}


//sample response for categories
// [
//     {
//         "id": 1,
//         "name": "Cleaning"
//     },
//     {
//         "id": 2,
//         "name": "Barber"
//     },
// ]