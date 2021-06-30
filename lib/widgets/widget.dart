import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png",
      height: 50,
    ),
  );
}

InputDecoration textFieldDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle underLineStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
    decoration: TextDecoration.underline,
  );
}

List<Color> myColorList = [
  Color(0xff007ef4),
  Color(0xff2a75bc),
];

List<Color> opponentColorList = [
  Color(0x1affffff),
  Color(0x1affffff),
];

BorderRadius myRadius = BorderRadius.only(
  topLeft: Radius.circular(23),
  topRight: Radius.circular(23),
  bottomLeft: Radius.circular(23),
);

BorderRadius opponentRadius = BorderRadius.only(
  topLeft: Radius.circular(23),
  topRight: Radius.circular(23),
  bottomRight: Radius.circular(23),
);
