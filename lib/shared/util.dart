import 'package:flutter/material.dart';

final screenWidth = WidgetsBinding.instance.renderView.size.width;
final screenHeight = WidgetsBinding.instance.renderView.size.height;

const sizedBoxHeight8 = SizedBox(height: 8);
const sizedBoxHeight16 = SizedBox(height: 16);

final borderRadiusCircular8 = BorderRadius.circular(8);

void onWidgetLoad(Function() x) {
  WidgetsBinding.instance.addPostFrameCallback((_) => x());
}
