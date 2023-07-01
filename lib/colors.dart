import 'package:flutter/material.dart';


const Color kGreenMainTheme = Color(0xff37c976);
const Color kGreyTextColor = Color(0xff878080);
const Color kStatusColor = Color(0xff008000);

//Text style constants

//Input Text Field Decoration
const InputDecoration kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kGreenMainTheme, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kGreenMainTheme, width: 2),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

// otp input textbox

const InputDecoration kOtpText = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kGreenMainTheme, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kGreenMainTheme, width: 2),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
);

//page heading Font-Size

const TextStyle kWhiteHeadingSize = TextStyle(
    fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700); //white
const TextStyle kBlackHeadingSize = TextStyle(
    fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700); //black
//common grey text Style
const TextStyle kGreyTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Color(0xff878080),
);
//ticket styles

const TextStyle kGreyTextTicketStyle = TextStyle(
  fontSize: 22.5,
  fontWeight: FontWeight.w400,
  color: Color(0xff878080),
);

const TextStyle kBlackTicketTextSize = TextStyle(
    fontSize: 17.3, color: Colors.black, fontWeight: FontWeight.w400); 

const TextStyle kSmallGrey = TextStyle(color: kGreyTextColor, fontSize: 12);
const TextStyle kLargeGrey =
    TextStyle(fontWeight: FontWeight.w500, color: kGreyTextColor);

const TextStyle kSOEStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const TextStyle kDestinationStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

const TextStyle kGreyFormTextStyle = TextStyle(
  color: kGreyTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

//otp package themes



