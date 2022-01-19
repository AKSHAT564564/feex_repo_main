import 'package:feex/models/customer_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerAddressProvider extends ChangeNotifier {
  bool _hasAddress = false;
  List<CustomerAddressModel> _customerAddresss = []; // class object
  bool _guestUser = false;
  bool _error = false;
  String _errorMessage = '';

  bool get hasAddress => _hasAddress;
  bool get guestUser => _guestUser;
  List<CustomerAddressModel> get customerAddresss => _customerAddresss;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  //function to fetch customer details
  fetchCustomerAddress() async {
    String url =
        'https://feex.herokuapp.com/api/customer/address/'; //endpoint to fetch all customer details

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');
    if (accessToken != 'null') {
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        try {
          var jsonResponse = json.decode(response.body) as List;
          _customerAddresss = jsonResponse
              .map((e) => CustomerAddressModel.fromJson(e))
              .toList();
          print('customer ${_customerAddresss.toString()}');
          _hasAddress = true;
          _error = false;
        } catch (e) {
          _hasAddress = false;
          _error = true;
          _errorMessage = '';
        }
      } else {
        _hasAddress = false;
        _error = true;
        _errorMessage = '';
      }
    } else {
      _guestUser = true; //access_token is set as null for guest user
      _hasAddress = false;
    }
    notifyListeners();
  }

  addAddress(Map<String, dynamic> addressData) async {
    String url = 'https://feex.herokuapp.com/api/customer/address/';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = await sharedPreferences.getString('access_token');

    if (accessToken != 'null') {
      var response = await http.post(Uri.parse(url),
          headers: {'Authorization': 'Bearer $accessToken'}, body: addressData);
      print(response.body.toString());
      if (response.statusCode == 201) {
        return 'success';
      } else if (response.statusCode == 400) {
        return 'failure';
      } else {
        return 'failure';
      }
    }
  }
}
