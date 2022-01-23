import 'package:flutter/material.dart';

class CustomerAddressModel {
  final int id;
  final name;
  final type;
  final area;
  final street;
  final buildingHouse;
  final floor;
  final apartmentOffice;

  CustomerAddressModel(
      {this.id = 0,
      this.name = '',
      this.type = '',
      this.street = '',
      this.area = '',
      this.buildingHouse = '',
      this.floor = '',
      this.apartmentOffice = ''});

  factory CustomerAddressModel.fromJson(Map<String, dynamic> json) {
    return CustomerAddressModel(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        area: json['area'],
        street: json['street'],
        buildingHouse: json['building_house'],
        floor: json['floor'],
        apartmentOffice: json['apartment_office']);
  }
}

// Sample json response

// {
//     "id": 1,
//     "name": "Home",
//     "type": "apartment",
//     "area": "hata pyare lal",
//     "street": "jhansi",
//     "building_house": "1",
//     "floor": 1,
//     "apartment_office": 1
// }
