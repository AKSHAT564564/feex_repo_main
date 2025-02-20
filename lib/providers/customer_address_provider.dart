import 'package:feex/models/customer_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerAddressProvider extends ChangeNotifier {
  bool _hasAllAddress = false;
  List<CustomerAddressModel> _customerAddresss = []; // class object
  bool _guestUser = false;
  bool _error = false;
  String _errorMessage = '';

  bool get hasAllAddress => _hasAllAddress;
  bool get guestUser => _guestUser;
  List<CustomerAddressModel> get customerAddresss => _customerAddresss;
  bool get error => _error;
  String get errorMessage => _errorMessage;

 

  //function to fetch customer details
  fetchAllCustomerAddress() async {
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
          _hasAllAddress = true;
          _error = false;
        } catch (e) {
          _hasAllAddress = false;
          _error = true;
          _errorMessage = '';
        }
      } else {
        _hasAllAddress = false;
        _error = true;
        _errorMessage = '';
      }
    } else {
      _guestUser = true; //access_token is set as null for guest user
      _hasAllAddress = false;
    }
    notifyListeners();
  }

  bool _hasAddress = false;
  CustomerAddressModel? _customerAddressModel;

  bool get hasAddress => _hasAddress;
  CustomerAddressModel? get customerAddressModel => _customerAddressModel;

  fetchAddressFromAddressId(addressId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');

    String url = 'https://feex.herokuapp.com/api/customer/address/$addressId/';

    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _customerAddressModel = CustomerAddressModel.fromJson(jsonResponse);
      _hasAddress = true;
    } else {
      _customerAddressModel = null;
      _hasAddress = false;
    }
    notifyListeners();
  }

  addAddress(Map<String, dynamic> addressData) async {
    String url = 'https://feex.herokuapp.com/api/customer/address/';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');

    Map<String, dynamic> responseMap = {};

    if (accessToken != 'null') {
      var response = await http.post(Uri.parse(url),
          headers: {'Authorization': 'Bearer $accessToken'}, body: addressData);
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 201) {
        responseMap['statusCode'] = 200;
      } else if (response.statusCode == 400) {
        responseMap['response'] = jsonResponse;
        responseMap['statusCode'] = 400;
      } else {
        responseMap['statusCode'] = 500;
      }
    }

    return responseMap;
  }

  editAddress(addressId, addressData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');
    String url = 'https://feex.herokuapp.com/api/customer/address/$addressId/';

    var response = await http.patch(Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'}, body: addressData);

    Map<String, dynamic> responseMap = {};

    if (response.statusCode == 200) {
      responseMap['statusCode'] = 200;
    } else if (response.statusCode == 400) {
      responseMap['response'] = json.decode(response.body);
      responseMap['statusCode'] = 400;
    } else {
      responseMap['statusCode'] = 500;
    }
    return responseMap;
  }

  deleteAddress(addressId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');
    String url = 'https://feex.herokuapp.com/api/customer/address/$addressId/';

    var response = await http.delete(Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 204) {
      return 'success';
    } else {
      return 'failed';
    }
  }
}
