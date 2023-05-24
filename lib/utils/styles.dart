

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';

BoxDecoration get tureguBackground {
  return BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryColor, Colors.white],
  ));
}

BoxDecoration get notificationBackgroundGradient{
  return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [primaryColor,textColorGreen],
      ));
}

TextStyle get headingStyle {
  return const TextStyle(
    fontSize: 26,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: textColorGreen,
  );
}

TextStyle get titleStyle {
  return const TextStyle(
      fontSize: 16,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      color: Colors.black);
}

TextStyle get regularTextStyle{
  return const TextStyle(
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
  );
}

TextStyle get subtitleStyle {
  return TextStyle(
    fontSize: 14,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    color: Colors.grey[400],
  );
}
