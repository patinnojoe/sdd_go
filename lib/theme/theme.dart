import 'package:flutter/material.dart';

// textform field styling
var textformfield = const InputDecoration(
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.red),
  ),
  labelStyle: TextStyle(color: Colors.black),
  hintText: 'First Name',
  hintStyle: TextStyle(color: Colors.black),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.black),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.red),
  ),
  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
);

var heightBox = const SizedBox(
  height: 20,
);

// container image for background

var backgroundImage = const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/onboarding page.png'),
        fit: BoxFit.cover));

// button style for elevated buttons
var raisedBtnStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.red),
);
