import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/providers/customer_address_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserAddAddress extends StatefulWidget {
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

  String addressType = 'Apartment';

  @override
  Widget build(BuildContext context) {
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
        ),
        body: Container(
          padding: EdgeInsets.all(20),
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
                    child: DropdownButton<String>(
                      value: addressType,
                      icon: null,
                      elevation: 0,
                      isExpanded: true,
                      style: const TextStyle(color: kPrimaryColor),
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          addressType = newValue!;
                          _typeController.text = addressType.toLowerCase();
                        });
                      },
                      items: <String>['Apartment', 'House', 'Office']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
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
                      bool failed = false;
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        setState(() {
                          _isLoading = true;
                        });

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
