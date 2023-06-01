import 'package:flutter/material.dart';

  /// <img width="100" alt="image" src="https://github.com/memspace/zefyr/assets/18584572/7e3e8353-1240-49c5-81e9-bbf8561fd9be">
class IColor {
  static final IColor _singleton = IColor._internal();

  /// <img width="100" alt="image" src="https://github.com/memspace/zefyr/assets/18584572/7e3e8353-1240-49c5-81e9-bbf8561fd9be">
  factory IColor() {
    return _singleton;
  }

  IColor._internal();

  Color get background => const Color(0xffF1F6F9);
  Color get primary => const Color(0xff212A3E);
  Color get secondary => const Color(0xff394867);
  Color get tertiary => const Color(0xff9BA4B5);
}
