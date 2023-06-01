import 'package:flutter/material.dart';
import 'package:posay/shared/screen_size.dart';
import 'package:posay/shared/constants/screen_size_provider.dart';

class Constants {
  final ScreenSizeProvider screenSizeProvider;

  Constants({required this.screenSizeProvider});

  ScreenSize get screenSize => screenSizeProvider.screenSize;

  final sizedBoxHeight8 = const SizedBox(height: 8);
  final sizedBoxHeight16 = const SizedBox(height: 16);
  final radiusCircular8 = BorderRadius.circular(8);
  final edgesRight8 = const EdgeInsets.only(right: 8);
  final edgesAll16 = const EdgeInsets.all(16); 
}
