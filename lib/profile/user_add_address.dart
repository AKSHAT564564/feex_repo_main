import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/models/customer_address_model.dart';
import 'package:feex/providers/customer_address_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserAddAddress extends StatefulWidget {
  final bool isEditingAddress;
  var customerAddressModel;
  //theese help in adding and editing address in the same screen
  // they have usual meaning
  UserAddAddress(
      {this.isEditingAddress = false, this.customerAddressModel = null});

  @override
  State<UserAddAddress> createState() => _UserAddAddressState();
}

class _UserAddAddressState extends State<UserAddAddress> {
  final _nameController = TextEditingController();

  final _typeController = TextEditingController();

  final _areaController = TextEditingController();

  final _streetController = TextEditingController();

  final _buildingHouseController = TextEditingController();

  final _floorController = TextEditingController();

  final _apartmentOfficecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Map<String, dynamic> addressData = {
    'name': '',
    'type': '',
    'area': '',
    'street': '',
    'building_house': '',
    'floor': '',
    'apartment_office': ''
  };

  // store json response of every feild
  // acoridng to key value pair
  Map<String, dynamic> _errorHandling = {
    'name': '',
    'type': '',
    'area': '',
    'street': '',
    'building_house': '',
    'floor': '',
    'apartment_office': ''
  };

  credentialsFeild(TextEditingController controller, hintText, errorText,
      obscureText, feildIcon, feildName) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return 'please enter $hintText';
      },
      onChanged: (value) {
        addressData[feildName] = controller.text;
        setState(() {
          _errorHandling[feildName] = '';
        });
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        errorText: _errorHandling[feildName] == ''
            ? null
            : _errorHandling[feildName].toString(),
        focusColor: Colors.grey,
        hintText: hintText,
        suffixIcon: feildIcon,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(
            color: kBorderGreyColor,
            width: 1,
          ),
        ),
      ),
    );
  }

  ValueNotifier<String> addressType = ValueNotifier<String>('Apartment');

  // String addressType = 'Apartment';
  bool storedInitialData = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isEditingAddress && !storedInitialData) {
      //if user is editing address
      //initializing the feilds
      CustomerAddressModel customerAddressModel = widget.customerAddressModel;

      _areaController.text = addressData['area'] = customerAddressModel.area;
      _typeController.text = addressData['type'] = customerAddressModel.type;
      _apartmentOfficecontroller.text = addressData['apartment_office'] =
          customerAddressModel.apartmentOffice.toString();
      _buildingHouseController.text =
          addressData['building_house'] = customerAddressModel.buildingHouse;
      _nameController.text = addressData['name'] = customerAddressModel.name;
      _streetController.text =
          addressData['street'] = customerAddressModel.street;
      _floorController.text =
          addressData['floor'] = customerAddressModel.floor.toString();
      storedInitialData = true;
    }

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
              )),
          elevation: 1,
          title: const Text(
            'Add Address',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            widget.isEditingAddress == true
                ? IconButton(
                    onPressed: () async {
                      await CustomerAddressProvider()
                          .deleteAddress(widget.customerAddressModel.id)
                          .then((v) {
                        if (v == 'success') {
                          Navigator.pop(context);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: greenColor,
                    ))
                : const Center()
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  const Text(
                    'Enter following Details to add Addresses :',
                    style: TextStyle(color: kSecondaryColor),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  //dropdown for selecting item type
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            color: const Color(0xffE3DEF8), width: 1.0)),
                    child: ValueListenableBuilder(
                        valueListenable: addressType,
                        builder: (_, addressTypeValue, __) {
                          return DropdownButton<String>(
                            value: addressType.value,
                            icon: null,
                            elevation: 0,
                            isExpanded: true,
                            style: const TextStyle(color: kPrimaryColor),
                            underline: Container(
                              height: 0,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              addressType.value = newValue!;
                              addressData['type'] =
                                  addressType.value.toLowerCase();
                              _typeController.text =
                                  addressType.value.toLowerCase();
                            },
                            items: <String>['Apartment', 'House', 'Office']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  credentialsFeild(
                      _nameController, 'Name', false, false, null, 'name'),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  credentialsFeild(
                      _areaController, 'Area', false, false, null, 'area'),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  credentialsFeild(_streetController, 'Street', false, false,
                      null, 'street'),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  credentialsFeild(
                      _buildingHouseController,
                      'Building House number',
                      false,
                      false,
                      null,
                      'building_house'),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  credentialsFeild(
                      _floorController, 'floor', false, false, null, 'floor'),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  credentialsFeild(
                      _apartmentOfficecontroller,
                      'Aprtment Office',
                      false,
                      false,
                      null,
                      'apartment_office'),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  DefaultButton(
                    text: 'Add Address',
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        setState(() {
                          _isLoading = true;
                        });

                        if (widget.isEditingAddress == false) {
                          await CustomerAddressProvider()
                              .addAddress(addressData)
                              .then((v) {
                            //we are getting a Map as a response to the fucntion call
                            //if sucess a statusCode feild is added with value 200 is added
                            //if failure or wrong feilds statusCode is made 400 and error response is added
                            // to 'response' feild in the return value i.e. 'v'
                            if (v['statusCode'] == 200) {
                              Navigator.pop(context);
                            } else if (v['statusCode'] == 500) {
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              Map<String, dynamic> errors = v['response'];
                              for (var item in errors.keys) {
                                setState(() {
                                  _errorHandling[item] = errors[item];
                                });
                              }
                            }
                          });
                        } else {
                          await CustomerAddressProvider()
                              .editAddress(
                                  widget.customerAddressModel.id, addressData)
                              .then((v) {
                            if (v['statusCode'] == 200) {
                              Navigator.pop(context);
                            } else if (v['statusCode'] == 500) {
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              Map<String, dynamic> errors = v['response'];
                              for (var item in errors.keys) {
                                setState(() {
                                  _errorHandling[item] = errors[item];
                                });
                              }
                            }
                          });
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
