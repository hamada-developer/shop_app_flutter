import 'package:flutter/material.dart';

import 'color.dart';

final ThemeData lightMode = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'MyFlutterApp',
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[100],
    elevation: 30,
    type: BottomNavigationBarType.fixed,
  ),
);
