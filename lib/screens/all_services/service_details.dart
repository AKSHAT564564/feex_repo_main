import 'package:feex/components/app_bar_component.dart';
import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/models/service_details_data_model.dart';
import 'package:feex/models/service_time_slots_model.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceDetails extends StatefulWidget {
  final ServiceDetailsDataModel serviceDetails;
  const ServiceDetails({required this.serviceDetails, Key? key})
      : super(key: key);
  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServiceDetailProvider>(context, listen: false)
        .fetchServiceOptions(widget.serviceDetails.serviceId);
    Provider.of<ServiceDetailProvider>(context, listen: false)
        .fetchServiceTimeSlots(widget.serviceDetails.serviceId);
  }

  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   Provider.of<ServiceDetailProvider>(context, listen: false)
  //       .initialValuesForServiceOptions();
  // }

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

  int selectedPrice = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              ServiceDetailProvider().serviceOptionss = [];
              Navigator.pop(context);
            },
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
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  widget.serviceDetails.serviceName,
                  style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: const Text(
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
              const Text(
                'Service Price',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 90,
                  child:
                      Consumer<ServiceDetailProvider>(builder: (_, value, __) {
                    return value.hasServiceOptions == false
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: value.serviceOptions.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedPrice = index;
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: selectedPrice == index
                                              ? greenColor
                                              : const Color(0xffE3DEF8),
                                          width: 1.0)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          value.serviceOptions[index].price
                                                  .toString() +
                                              ' AED',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'for ' +
                                              value.serviceOptions[index].title,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                  })),

              // const ListTile(
              //   contentPadding: EdgeInsets.all(0),
              //   title: Text(
              //     'Number of Rooms',
              //     style: TextStyle(
              //         color: kPrimaryColor,
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold),
              //   ),
              //   subtitle: Text(
              //     'Select the number of room for cleaning',
              //     style: TextStyle(fontSize: 15),
              //   ),
              // ),
              // Container(
              //   height: 32,
              //   width: 110,
              //   decoration: BoxDecoration(
              //       color: Color(0xffF5F5F5),
              //       borderRadius: BorderRadius.circular(60)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       IconButton(
              //           onPressed: null,
              //           icon: Icon(
              //             Icons.remove,
              //             size: 18,
              //             color: kPrimaryColor,
              //           )),
              //       Text(
              //         '1',
              //         style: TextStyle(fontSize: 18),
              //       ),
              //       IconButton(
              //           onPressed: null,
              //           icon: Icon(
              //             Icons.add,
              //             size: 18,
              //             color: kPrimaryColor,
              //           ))
              //     ],
              //   ),
              // ),
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
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              // Row(
              //   children: const [
              //     SizedBox(
              //       width: 120,
              //       child: ListTile(
              //         contentPadding: EdgeInsets.all(0),
              //         horizontalTitleGap: 0,
              //         leading: Radio(
              //             value: 'value',
              //             groupValue: 'groupValue',
              //             onChanged: null),
              //         title: Text(
              //           'ASAP',
              //           style: TextStyle(color: Colors.black, fontSize: 15),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 200,
              //       child: ListTile(
              //         horizontalTitleGap: 0,
              //         contentPadding: EdgeInsets.all(0),
              //         leading: Radio(
              //             value: 'value',
              //             groupValue: 'groupValue',
              //             onChanged: null),
              //         title: Text(
              //           'Schedule for Later',
              //           style: TextStyle(color: Colors.black, fontSize: 15),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.4,
                    height: 45,
                    child: Consumer<ServiceDetailProvider>(
                        builder: (_, value, __) {
                      List timeSlots = value.serviceTimeSlots;
                      return value.hasTimeSlots
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: const Color(0xffE3DEF8),
                                      width: 1.0)),
                              child: timeSlots.isEmpty
                                  ? const Center(
                                      child: Text('No Avaialbe slots'))
                                  : DropdownButton<String>(
                                      onChanged: null,
                                      elevation: 0,
                                      isExpanded: true,
                                      style:
                                          const TextStyle(color: kPrimaryColor),
                                      underline: Container(
                                        height: 0,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      items: timeSlots.map((e) {
                                        return DropdownMenuItem<String>(
                                            child: Text(e.slot.toString()));
                                      }).toList()
                                      //     timeSlots.map<DropdownMenuItem<ServiceTimeSlotModel>>((ServiceTimeSlotModel model) {
                                      //   return DropdownMenuItem<ServiceTimeSlotModel>(
                                      //       value: model.id, child: Text(model.slot));
                                      // }),
                                      ),
                            )
                          : CircularProgressIndicator();
                    }),
                    // child: credentialsFeild(_feildController, 'Choose Time',
                    //     false, false, const Icon(Icons.access_time)),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.4,
                    height: 45,
                    child: credentialsFeild(_feildController, 'Choose Date',
                        false, false, const Icon(Icons.calendar_today)),
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
              // credentialsFeild(
              //     _feildController,
              //     'Image or Video of the problem',
              //     false,
              //     false,
              //     const Icon(Icons.camera_alt_outlined)),
              // SizedBox(
              //   height: getProportionateScreenHeight(10),
              // ),
              // const Text('Maximum attachment 10MB'),
              // SizedBox(
              //   height: getProportionateScreenHeight(40),
              // ),
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
