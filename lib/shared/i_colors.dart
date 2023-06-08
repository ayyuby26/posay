import 'package:flutter/material.dart';

/// <img width="100" alt="image" src="https://github.com/memspace/zefyr/assets/18584572/7e3e8353-1240-49c5-81e9-bbf8561fd9be">
class IColor {
  static IColor? _instance;

  factory IColor() {
    _instance ??= IColor._();
    return _instance!;
  }

  IColor._();

  /// <img width="100" alt="image" src="https://github.com/memspace/zefyr/assets/18584572/7e3e8353-1240-49c5-81e9-bbf8561fd9be">

  IColor._internal();

  static Color get background => const Color(0xffF1F6F9);
  static Color get primary => const Color(0xff212A3E);
  static Color get secondary => const Color(0xff394867);
  static Color get tertiary => const Color(0xff9BA4B5);
  static Color get border => tertiary.withOpacity(.3);
}
