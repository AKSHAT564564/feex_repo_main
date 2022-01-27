import 'package:feex/models/customer_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CustomerDetailsProvider extends ChangeNotifier {
  bool _error = false;
  String _errorMessage = '';
  CustomerDetailsModel _customerDetailsModel =
      CustomerDetailsModel(name: 'Guest', email: '');
  bool _hasData = false;
  bool _isGuestUser = false;

  CustomerDetailsModel get customerDetailsModel => _customerDetailsModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get hasData => _hasData;

  bool get isGuestUser => _isGuestUser;

  fetchCustomerDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = await sharedPreferences.getString('access_token');

    if (accessToken == 'null') {
      _isGuestUser = true;
      //set Guest user to true and notify listners
    } else {
      _isGuestUser =
          false; //set guest user to false then fetches customer details
      var response = await http.get(
          Uri.parse('https://feex.herokuapp.com/api/customer/'),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        // code 200 means success

        try {
          var jsonResponse = json.decode(response.body);
          _customerDetailsModel = CustomerDetailsModel.fromJson(jsonResponse);
          _error = false;
        } catch (e) {
          _error = true;
          _errorMessage = e.toString();
          _customerDetailsModel = CustomerDetailsModel();
          print(_customerDetailsModel.toString());
        }
        _hasData = true; // for condtional rendering of widgets
      } else {
        _hasData = false;
        _error = true;
        _errorMessage = 'Unable to fetch Details';
      }
    }

    notifyListeners();
    return customerDetailsModel;
  }

  updateCustomerDetails(
      Map<String, dynamic> customerDetails, XFile? file) async {
    print(customerDetails.toString());
    String url = 'https://feex.herokuapp.com/api/customer/update-profile/1/';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = await sharedPreferences.getString('access_token');
    var request = http.MultipartRequest('PUT', Uri.parse(url));

    request.headers['Authorization'] = 'Bearer $accessToken';

    var picture = file == null
        ? http.MultipartFile.fromBytes(
            'profile_img',
            (await rootBundle.load('assets/images/user_default.png'))
                .buffer
                .asInt8List(),
            filename: 'user_default.png')
        : http.MultipartFile(
            'profile_img',
            File(file.path).readAsBytes().asStream(),
            File(file.path).lengthSync(),
            filename: file.name);

    // refer : https://androidkt.com/how-to-upload-image-using-multipart-in-flutter/
    // refer : https://www.androidcoding.in/2021/09/01/flutter-upload-image/

    request.files.add(picture);

    request.fields['name'] = customerDetails['name'];
    request.fields['dob'] = customerDetails['dob'];
    request.fields['mobile_number'] = customerDetails['mobile_number'];

    var response = await request.send();
    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    if (response.statusCode == 200) {
      return 'success';
    } else {
      return 'Failure';
    }

    // var response = await http.put(Uri.parse(url),
    //     headers: {'Authorization': 'Bearer $accessToken'},
    //     body: customerDetails);
    // print(response.body);

    // if (response.statusCode == 200) {
    //   print(response.body);
    //   return 'sucess';
    // } else {
    //   return 'failure';
    // }
  }

  void initialValues() {
    _customerDetailsModel = CustomerDetailsModel();
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
