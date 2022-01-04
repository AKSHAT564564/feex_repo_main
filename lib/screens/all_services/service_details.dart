import 'package:feex/components/app_bar_component.dart';
import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class ServiceDetails extends StatelessWidget {
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
        actions: const [
          TextButton(
              onPressed: null,
              child: Text(
                'Edit',
                style: TextStyle(color: greenColor),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Home Cleaning Service',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                subtitle: Text(
                  'Lorem Ipsum Dolor smith',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(
                thickness: 1,
                color: kBorderGreyColor,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const Text(
                'Service Price',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                        tag: '$index' + 'title',
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color(0xffE3DEF8), width: 1.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '20 AED',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text('for 1 Hour')
                            ],
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Number of Rooms',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Select the number of room for cleaning'),
              ),
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
                          size: 20,
                          color: kPrimaryColor,
                        )),
                    Text(
                      '1',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.add,
                          size: 20,
                          color: kPrimaryColor,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              const Text(
                'Choose Timing',
                style: TextStyle(
                    fontSize: 22,
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
                        style: TextStyle(color: Colors.black),
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
                        style: TextStyle(color: Colors.black),
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
                        false, false, Icon(Icons.access_time)),
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
