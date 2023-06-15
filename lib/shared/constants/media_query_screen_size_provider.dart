import 'package:flutter/material.dart';
import 'package:posay/shared/screen_size.dart';
import 'package:posay/shared/constants/screen_size_provider.dart';

class MediaQueryScreenSizeProvider implements ScreenSizeProvider {
  @override
  ScreenSize get screenSize {
    // ignore: deprecated_member_use
    final size = MediaQueryData.fromView(WidgetsBinding.instance.window).size;
    return ScreenSize(width: size.width, height: size.height);
  }
}
