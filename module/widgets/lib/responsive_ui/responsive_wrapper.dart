import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

extension ResponsiveWrapper on BuildContext {
  Widget responsiveWrapper({
    Widget? small,
    Widget? medium,
    Widget? large,
  }) {
    Widget selectedLayout = small ?? medium ?? large ?? const SizedBox();
    if (isLargeScreen && large != null) {
      selectedLayout = large;
    } else if (isMediumScreen && medium != null) {
      selectedLayout = medium;
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: selectedLayout,
            ),
          ),
          /*Positioned(
            top: 40,
            left: 10,
            child: showDebugInfo(),
          ), */
        ],
      ),
    );
  }
}
