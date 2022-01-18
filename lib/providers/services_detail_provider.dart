import 'package:feex/models/service_details_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceDetailProvider extends ChangeNotifier {
  bool _hasData = false;
  List<ServiceDetailsDataModel> _serviceDetails = [];
  bool _error = false;
  String _errorMessage = '';

  bool get error => _error;
  String get errorMessage => _errorMessage;
  List<ServiceDetailsDataModel> get serviceDetails => _serviceDetails;

  bool get hasData => _hasData;

  fetchAllServices(categoryId) async {
    var url = 'https://feex.herokuapp.com/api/services/?category=$categoryId';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body) as List;
        _serviceDetails = jsonResponse
            .map((e) => ServiceDetailsDataModel.fromJson(e))
            .toList();
        _error = false;
        _hasData = true;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _hasData = false;
      }
    } else {
      _error = true;
      _errorMessage = 'Unable to fetch Data';
    }
    return _serviceDetails;
  }
}
