import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class Theams {
  static final ThemeData lightTheam = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        outline: const Color(0xffE6E9EA),
        secondaryContainer: AppColor.white),
    fontFamily: 'Cairo',
    useMaterial3: true,
  );
  static final ThemeData darkTheam = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple, brightness: Brightness.dark),
  );
}
