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

  static const height8 = SizedBox(height: 8);
  static const height16 = SizedBox(height: 16);
  static const width16 = SizedBox(width: 16);
  static const sizedBoxW8 = SizedBox(width: 8);
  static final radiusCircular8 = BorderRadius.circular(8);
  static final radiusCircular16 = BorderRadius.circular(16);
  static final roundedCircular8 =
      RoundedRectangleBorder(borderRadius: radiusCircular8);
  static const edgesRight8 = EdgeInsets.only(right: 8);
  static final sizeFullWidthH55 = Size(screenSize.width, 55);
  static const edgesRight16 = EdgeInsets.only(right: 16);
  static const edgesAll16 = EdgeInsets.all(16);
  static const edgesAll8 = EdgeInsets.all(8);
  static const edgesSymmetricV8H16 =
      EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const edgesV16H8 = EdgeInsets.symmetric(vertical: 16, horizontal: 8);
}
