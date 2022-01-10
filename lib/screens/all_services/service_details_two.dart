import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class ServiceDetailsTwo extends StatelessWidget {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  String selectedValue = "USA";
  final _feildController = TextEditingController();

  credentialsFeild(controller, hintText, errorText, obscureText, suffixIcon) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return 'please enter $hintText';
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        errorText: errorText ? 'Check $hintText' : null,
        focusColor: kBorderGreyColor,
        hintText: hintText,
        suffixIcon: suffixIcon,
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

  Widget dropDownFeild() {
    return Container(
      height: 44,
      child: InputDecorator(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          errorText: false ? 'Check hintText' : null,
          focusColor: kBorderGreyColor,
          hintText: 'Number of bed Rooms',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
            borderSide: BorderSide(color: kBorderGreyColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
            borderSide: BorderSide(color: kBorderGreyColor, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
            borderSide: BorderSide(color: kBorderGreyColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
            borderSide: BorderSide(
              color: kBorderGreyColor,
              width: 1,
            ),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              value: selectedValue, onChanged: null, items: dropdownItems),
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
          'Service Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'AC unit Repair',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: Text(
                  'Lorem Ipsum Dolor smith',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Divider(
                thickness: 1,
                color: kBorderGreyColor,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              dropDownFeild(),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Service Price',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Select the number of units',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 32,
                    width: 110,
                    decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(60)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.remove,
                              size: 18,
                              color: kPrimaryColor,
                            )),
                        Text(
                          '1',
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.add,
                              size: 18,
                              color: kPrimaryColor,
                            ))
                      ],
                    ),
                  ),
                  const Text(
                    '60 AED',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const Text(
                'Choose Timing',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 120,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      horizontalTitleGap: 0,
                      leading: Radio(
                          value: 'value',
                          groupValue: 'groupValue',
                          onChanged: null),
                      title: Text(
                        'ASAP',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ListTile(
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.all(0),
                      leading: Radio(
                          value: 'value',
                          groupValue: 'groupValue',
                          onChanged: null),
                      title: Text(
                        'Schedule for Later',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.4,
                    height: 45,
                    child: credentialsFeild(_feildController, 'Choose Time',
                        false, false, const Icon(Icons.access_time)),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.4,
                    height: 45,
                    child: credentialsFeild(_feildController, 'Choose Date',
                        false, false, Icon(Icons.calendar_today)),
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const TextField(
                minLines: 5,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: 'Describe the problem',
                  contentPadding: EdgeInsets.all(10),
                  errorText: false ? 'Check ' : null,
                  focusColor: kBorderGreyColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: kBorderGreyColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: kBorderGreyColor, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: kBorderGreyColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(
                      color: kBorderGreyColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              credentialsFeild(
                  _feildController,
                  'Image or Video of the problem',
                  false,
                  false,
                  const Icon(Icons.camera_alt_outlined)),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              const Text('Maximum attachment 10MB'),
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: DefaultButton(
                  text: 'Request',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
