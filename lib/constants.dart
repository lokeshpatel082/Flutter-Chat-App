import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.indigoAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Aa...',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(30)),
  border: Border(
    top: BorderSide(color: Color(0xffd1c4e9), width: 2.0),
    right: BorderSide(color: Color(0xffd1c4e9), width: 2.0),
    left: BorderSide(color: Color(0xffd1c4e9), width: 2.0),
    bottom: BorderSide(color: Color(0xffd1c4e9), width: 2.0),
  ),
  color: Color(0xffEFEFEF),
);
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password',
  hintStyle: TextStyle(fontSize: 15.0, color: Colors.blueGrey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
