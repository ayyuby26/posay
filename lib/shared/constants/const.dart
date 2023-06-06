import 'package:flutter/material.dart';
import 'package:posay/shared/constants/media_query_screen_size_provider.dart';
import 'package:posay/shared/screen_size.dart';

class Const {
  static Const? _instance;

  factory Const() {
    _instance ??= Const._();
    return _instance!;
  }

  Const._();

  static ScreenSize get screenSize => MediaQueryScreenSizeProvider().screenSize;

  static const sizedBoxHeight8 = SizedBox(height: 8);
  static const sizedBoxHeight16 = SizedBox(height: 16);
  static final radiusCircular8 = BorderRadius.circular(8);
  static final radiusCircular16 = BorderRadius.circular(16);
  static const edgesRight8 = EdgeInsets.only(right: 8);
  static const edgesAll16 = EdgeInsets.all(16);
}
