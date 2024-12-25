import 'dart:math';

import 'package:flutter/material.dart';
import 'responsive_ui.dart';

extension ResponsiveWrapperExtension on BuildContext {
  double get minWidth => 400;
  double get minHeight => 600;

  Widget responsiveWrapper({
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    Widget selectedLeout;
    if (isDesktop) {
      selectedLeout = desktop ?? tablet ?? mobile;
    } else if (isTablet) {
      selectedLeout = tablet ?? mobile;
    } else {
      selectedLeout = mobile;
    }
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: minHeight,
          maxWidth: max(screenWidth, minWidth),
          maxHeight: max(screenHeight, minHeight),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: max(screenHeight, minHeight),
            width: double.infinity,
            child: selectedLeout,
          ),
        ),
      ),
    );
  }
}
