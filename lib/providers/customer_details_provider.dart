import 'package:feex/models/customer_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetailsProvider extends ChangeNotifier {
  bool _error = false;
  String _errorMessage = '';
  CustomerDetailsModel _customerDetailsModel = CustomerDetailsModel();
  bool _hasData = false;

  CustomerDetailsModel get customerDetailsModel => _customerDetailsModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get hasData => _hasData;

  fetchCustomerDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = await sharedPreferences.getString('access_token');

    var response = await http.get(
        Uri.parse('https://feex.herokuapp.com/api/customer/'),
        headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      _hasData = true;
      try {
        var jsonResponse = json.decode(response.body);
        _customerDetailsModel = CustomerDetailsModel.fromJson(jsonResponse);
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _customerDetailsModel = CustomerDetailsModel();
      }
    } else {
      _hasData = false;
      _error = true;
      _errorMessage = 'Unable to fetch Details';
    }
    notifyListeners();
  }

  void initialValues() {
    _customerDetailsModel = CustomerDetailsModel();
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
