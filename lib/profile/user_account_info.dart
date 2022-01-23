import 'dart:io';

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
  final _nameController = TextEditingController();

  final _mobileNumberController = TextEditingController();

  final _genderController = TextEditingController();

  final _dobController = TextEditingController();

  DateTime currentDate = DateTime.now();

  Map<String, dynamic> customerDetails = {
    'name': '',
    'mobile_number': '',
    'dob': '',
    'gender': '',
    'profile_img': '',
  };

  bool _isLoading = false;

  final ValueNotifier<int> radioButton =
      ValueNotifier<int>(-1); //using valuenotifier to update radio buttons
  //without setState Method

  final ImagePicker _picker = ImagePicker();

  final ValueNotifier<XFile?> pickedImage =
      ValueNotifier(null); // using to avoid setState

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
    pickedImage.value = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage.value != null) {
      customerDetails['profile_img'] = pickedImage.value; //storing picked image
    }
  }

  removePickedImage() async {
    pickedImage.value = null;
    customerDetails['profile_img'] =
        'assets/images/user_default.png'; //setting default image
  }

  credentialsFeild(
      controller, hintText, errorText, obscureText, feildIcon, feildName) {
    //felidName is for storing Data in the map
    //according to the valid feild
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return 'please enter $hintText';
      },
      onChanged: (value) {
        customerDetails[feildName] = value;
      },
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

  bool storedInitialValue =
      false; //using this to store initial details of customer only once
  //Consumer updates initial values each time
  //Defeating the purpose
  //Turns true once initial values are stored in the map

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
            if (storedInitialValue == false) {
              customerDetails['name'] =
                  _nameController.text = value.customerDetailsModel.name;
              customerDetails['mobile_number'] = _mobileNumberController.text =
                  value.customerDetailsModel.mobileNumber;
              customerDetails['dob'] =
                  _dobController.text = value.customerDetailsModel.dob;
              customerDetails['gender'] =
                  _genderController.text = value.customerDetailsModel.gender;

              //initializing radio buttons
              if (value.customerDetailsModel.gender == 'Male') {
                radioButton.value = 1;
              } else {
                radioButton.value = 2;
              }
              storedInitialValue = true;
            }
            return SingleChildScrollView(
              child: Column(
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
                              customerDetails['dob'] = _dobController.text;
                            });
                          },
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: kBorderGreyColor,
                          )),
                      'dob'),
                  SizedBox(height: getProportionateScreenHeight(25)),
                  ValueListenableBuilder<XFile?>(
                      valueListenable: pickedImage,
                      builder: (_, imageValue, __) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            pickedImage.value != null
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        Image.file(File(imageValue!.path))
                                            .image,
                                  )
                                : const SizedBox(),
                            ElevatedButton(
                                onPressed: () async {
                                  await pickImage();
                                },
                                child: pickedImage.value == null
                                    ? const Text('Pick Profle Image')
                                    : const Text('Change Image')),
                            pickedImage.value != null
                                ? TextButton(
                                    onPressed: () async {
                                      await removePickedImage();
                                    },
                                    child: const Text('Remove Image'))
                                : const SizedBox()
                          ],
                        );
                      }),
                  SizedBox(height: getProportionateScreenHeight(25)),
                  const Text(
                    'Gender (optional)',
                    style: TextStyle(color: kSecondaryColor),
                  ),
                  ValueListenableBuilder<int>(
                      //listning to change in radioButton value
                      //avoiding setState Method

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
                                      customerDetails['gender'] =
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
                                      customerDetails['gender'] = 'Female';
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: _isLoading
                          ? LinearProgressIndicator(
                              color: kPrimaryColor,
                            )
                          : DefaultButton(
                              text: 'Save',
                              press: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                String result = '';
                                await CustomerDetailsProvider()
                                    .updateCustomerDetails(
                                        customerDetails, pickedImage.value)
                                    .then((v) {
                                  result = v;
                                });
                                if (result == 'success') {
                                  await CustomerDetailsProvider()
                                      .fetchCustomerDetails(); // updating details of the customer
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                            ),
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
