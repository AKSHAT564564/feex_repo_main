import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/providers/customer_details_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserAccountInfo extends StatefulWidget {
  @override
  State<UserAccountInfo> createState() => _UserAccountInfoState();
}

class _UserAccountInfoState extends State<UserAccountInfo> {
  final ImagePicker _picker = ImagePicker();

  final _nameController = TextEditingController();

  final _mobileNumberController = TextEditingController();

  final _genderController = TextEditingController();

  final _dobController = TextEditingController();

  DateTime currentDate = DateTime.now();

  Map<String, dynamic> _customerDetails = {
    'name': '',
    'mobile_number': '',
    'dob': '',
    'gender': '',
    'profile': '',
  };

  final ValueNotifier<int> radioButton =
      ValueNotifier<int>(-1); //using valuenotifier to update radio buttons
  //without setState Method

  selectDate() async {
    //Date picker
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2023));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('abcd ${image.path}');
    }
  }
  

  credentialsFeild(
      controller, hintText, errorText, obscureText, feildIcon, feildName) {
    //felidName is for storing Data int the map
    //accprding to the valid feild
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return 'please enter $hintText';
      },
      onChanged: (value) => _customerDetails[feildName] = controller.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        errorText: errorText ? 'Check $hintText' : null,
        focusColor: kBorderGreyColor,
        hintText: hintText,
        suffixIcon: feildIcon,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: kBorderGreyColor, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: kBorderGreyColor, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: kBorderGreyColor, width: 1),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Account Information',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(18.0),
          child: Consumer<CustomerDetailsProvider>(builder: (_, value, __) {
            // storing initial values from the database

            _customerDetails['name'] = value.customerDetailsModel.name;
            _customerDetails['mobile_number'] =
                value.customerDetailsModel.mobileNumber;
            _customerDetails['dob'] = value.customerDetailsModel.dob;
            _customerDetails['gender'] = value.customerDetailsModel.gender;

            //initializing radio buttons
            if (value.customerDetailsModel.gender == 'Male') {
              radioButton.value = 1;
            } else {
              radioButton.value = 2;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(25)),
                credentialsFeild(
                    _nameController,
                    value.customerDetailsModel.name,
                    false,
                    false,
                    null,
                    'name'),
                SizedBox(height: getProportionateScreenHeight(25)),
                credentialsFeild(
                    _mobileNumberController,
                    value.customerDetailsModel.mobileNumber,
                    false,
                    false,
                    null,
                    'mobile_number'),
                // SizedBox(height: getProportionateScreenHeight(25)),
                // credentialsFeild(
                //     , 'Gender', false, false, null),
                SizedBox(height: getProportionateScreenHeight(25)),
                credentialsFeild(
                    _dobController,
                    value.customerDetailsModel.dob,
                    false,
                    false,
                    IconButton(
                        onPressed: () async {
                          await selectDate().then((v) {
                            _dobController.text =
                                currentDate.toString().substring(0, 10);
                            _customerDetails['dob'] = _dobController.text;
                          });
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: kBorderGreyColor,
                        )),
                    'dob'),
                SizedBox(height: getProportionateScreenHeight(25)),
                const Text(
                  'Gender (optional)',
                  style: TextStyle(color: kSecondaryColor),
                ),
                ValueListenableBuilder<int>(
                    //listning to change in radioButton value
                    // 1 for male
                    // 2 for female
                    valueListenable: radioButton,
                    builder: (_, genderValue, __) {
                      return Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Radio(
                                  value: 1, //1 for male
                                  groupValue:
                                      genderValue, // signifying the group ther are in
                                  activeColor: kPrimaryColor,
                                  onChanged: (v) {
                                    radioButton.value =
                                        1; //on selecting radioButton variable will be updated to
                                    //desired value then it wil upadate the state of radio button
                                    //using value listner
                                    _customerDetails['gender'] =
                                        'Male'; // updating the data
                                  }),
                              const Text(
                                'Male',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 2, // 2 for female
                                  groupValue:
                                      genderValue, // signifying the group
                                  activeColor: kPrimaryColor,
                                  onChanged: (v) {
                                    radioButton.value = 2;
                                    _customerDetails['gender'] = 'Female';
                                  }),
                              const Text(
                                'Female',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      );
                    }),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: DefaultButton(
                      text: 'Save',
                      press: () async {
                        pickImage();
                      },
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }
}
