import 'package:feex/models/customer_address_model.dart';
import 'package:feex/models/service_time_slots_model.dart';

// DATA MODEL FOR REQUEST-SERVICE API

class RequestedServiceDataModel {
  int id;
  ServiceModel serviceModel;
  String date;
  ServiceTimeSlotModel timeSlotModel;
  String description;
  CustomerAddressModel customerAddressModel;
  String status;

  RequestedServiceDataModel(
      {required this.id,
      required this.serviceModel,
      required this.timeSlotModel,
      this.description = '',
      required this.customerAddressModel,
      required this.status,
      required this.date});

  factory RequestedServiceDataModel.fromJson(Map<String, dynamic> json) {
    // TEMP VARIABLE
    // TO CREATE DATA MODEL OF json['service']
    // it takes only id and name
    //fetching the map in json['service']
    var tempServiceModelData = json['service'] as Map<String, dynamic>;

    return RequestedServiceDataModel(
        id: json['id'],
        serviceModel: ServiceModel(
            id: tempServiceModelData['id'], name: tempServiceModelData['name']),
        timeSlotModel:
            ServiceTimeSlotModel.fromJson(json['time'] as Map<String, dynamic>),
        description: json['description'],
        customerAddressModel: CustomerAddressModel.fromJson(
            json['address'] as Map<String, dynamic>),
        status: json['status'],
        date: json['date']);
  }
}

class ServiceModel {
  int id;
  String name;
  ServiceModel({required this.id, required this.name});
}

//sample response
// {
//         "id": 7,
//         "service": {
//             "id": 9,
//             "name": "Beard"
//         },
//         "date": "2022-01-23",
//         "time": {
//             "id": 2,
//             "slot": "12 - 14"
//         },
//         "description": "uuu",
//         "address": {
//             "id": 5,
//             "name": "Apartment"
//         },
//         "status": "Requested"
//   },
