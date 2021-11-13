import 'package:flutter/material.dart';

const kServerUrl = 'http://localhost:5000/api';

const List<IconData> kIconQuickList = [
  Icons.monetization_on_outlined,
  Icons.receipt_outlined,
  Icons.payments_outlined,
  Icons.payments_outlined,
  Icons.help_outline,
];

const kWidgetSpotlightText = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kUserEmail = 'fiap@fiap.com';

const kActiveElevatedButtonTextStyle = TextStyle(color: Colors.black);
const kInactiveElevatedButtonTextStyle = TextStyle(color: Colors.white);
const kWidgetText = TextStyle(color: Colors.white);
const kWidgetAllCards = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

final kActiveElevatedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: const BorderSide(color: Colors.white),
    ));

final kInactiveElevatedButtonStyle = ElevatedButton.styleFrom(
  primary: const Color(0x66C8C8C8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    side: const BorderSide(color: Colors.white),
  ),
);
