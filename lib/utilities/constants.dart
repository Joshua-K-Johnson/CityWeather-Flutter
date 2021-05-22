import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);
const kLabelTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 35.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  shadows: <Shadow>[
    Shadow(
      color: Colors.black,
      blurRadius: 2.0,
      offset: Offset(-3.0, 3.0),
    ),
  ],
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
const kInputTextFieldStyle = InputDecoration(
    icon: Icon(
      Icons.location_city,
      color: Colors.white,
    ),
    filled: true,
    fillColor: Colors.white,
    hintText: 'Enter the City',
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide.none,
    ));
