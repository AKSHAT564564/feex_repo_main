import 'package:feex/models/quotation_data_model.dart';
import 'package:feex/models/requested_service_data_model.dart';
import 'package:feex/models/service_details_data_model.dart';
import 'package:feex/models/service_options_data_model.dart';
import 'package:feex/models/service_time_slots_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<ServiceOptionsDataModel> _serviceOptions = [];
  bool _hasServiceOptions = false;

  List<ServiceOptionsDataModel> get serviceOptions => _serviceOptions;
  set serviceOptionss(value) {
    _serviceOptions = [];
    _hasServiceOptions = false;
  }

  bool get hasServiceOptions => _hasServiceOptions;

  fetchServiceOptions(serviceId) async {
    String url = 'https://feex.herokuapp.com/api/options/?service=$serviceId';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body) as List;

        _serviceOptions = jsonResponse
            .map((e) => ServiceOptionsDataModel.fromJson(e))
            .toList();

        _hasServiceOptions = true;
      } catch (e) {
        _serviceOptions = [];
        _hasServiceOptions = false;
      }
    } else {
      _serviceOptions = [];
      _hasServiceOptions = false;
    }
    notifyListeners();
  }

  List<int> _dropDownID = [];
  List<ServiceTimeSlotModel> _serviceTimeSlots = [];
  bool _hasTimeSlots = false;

  List<int> get dropDownID => _dropDownID;
  List<ServiceTimeSlotModel> get serviceTimeSlots => _serviceTimeSlots;
  bool get hasTimeSlots => _hasTimeSlots;
  fetchServiceTimeSlots(serviceId) async {
    String url =
        'https://feex.herokuapp.com/api/time-slots/?service=$serviceId';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body) as List;
        _serviceTimeSlots =
            jsonResponse.map((e) => ServiceTimeSlotModel.fromJson(e)).toList();

        for (var i = 0; i < _serviceTimeSlots.length; i++) {
          _dropDownID.add(i);
        }
        _hasTimeSlots = true;
      } catch (e) {
        _hasTimeSlots = false;
      }
    } else {
      _hasTimeSlots = false;
    }
    notifyListeners();
  }

  requestService(Map<String, dynamic> requestServiceDetials) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');

    var url = 'https://feex.herokuapp.com/api/request-service/';

    var response = await http.post(Uri.parse(url),
        body: json.encode(requestServiceDetials),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-type': 'application/json',
        });

    if (response.statusCode == 201) {
      return 'success';
    } else {
      return 'failure';
    }
  }

  List<RequestedServiceDataModel> _allRequestedServices = [];
  bool _hasAllRequestedServices = false;

  List<RequestedServiceDataModel> get allRequestedServices =>
      _allRequestedServices;

  bool get hasAllRequestedServices => _hasAllRequestedServices;

  getAllReuestedServiced() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');

    String url = 'https://feex.herokuapp.com/api/request-service/';

    if (accessToken != 'null') {
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode == 200) {
        try {
          var jsonResponse = json.decode(response.body) as List;

          _allRequestedServices = jsonResponse
              .map((e) => RequestedServiceDataModel.fromJson(e))
              .toList();

          _hasAllRequestedServices = true;
        } catch (e) {
          _hasAllRequestedServices = false;
        }
      } else {
        _hasAllRequestedServices = false;
      }
    }
    notifyListeners();
  }

  bool _hasQuotationData = false;

  bool get hasQuotationData => _hasQuotationData;

  QuotationDataModel? _quotationDataModel;

  QuotationDataModel? get quotattionDataModel => _quotationDataModel;

  getQuotationDetails(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');

    if (accessToken == 'null') return;

    String url = 'https://feex.herokuapp.com/api/quotation/$id/';

    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      _quotationDataModel = QuotationDataModel.fromJson(jsonResponse);
      _hasQuotationData = true;
    } else {
      _hasQuotationData = false;
    }
    notifyListeners();
  }

  initialValuesForServiceOptions() {
    _serviceOptions = [];
    _hasServiceOptions = false;
  }
}
