import 'package:feex/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff211452);
const kSecondaryColor = Color(0xff9F9AB4);
const greenColor = Color(0xff95C11F);
const lightBlueColor = Color(0xff9F9AB4);
const skyBlueColor = Color(0xffD9E3FF);
const kBorderGreyColor = Color(0xffc9c7d4);

// const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

//icons paths

final kPendingIcon = 'assets/images/clock_icon.png';
final kCompletedIcon = 'assets/images/completed_icon.png';
final kCancelledIcon = 'assets/images/cancelled_icon.png';
