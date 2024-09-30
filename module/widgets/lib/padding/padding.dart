import 'package:flutter/material.dart';

extension PaddingEXT on Widget {
  Padding paddingAll(double toDouble) {
    return Padding(
      padding: EdgeInsets.all(toDouble),
      child: this,
    );
  }

  Padding paddingSymetric(double toVertical, double toHorizontal) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: toVertical, horizontal: toHorizontal),
      child: this,
    );
  }

  Padding paddingOnly(
      double toLeft, double toRight, double toTop, double toBottom) {
    return Padding(
      padding: EdgeInsets.only(
        left: toLeft,
        right: toRight,
        top: toTop,
        bottom: toBottom,
      ),
      child: this,
    );
  }

  Padding paddingLeft(double toDouble) {
    return Padding(
      padding: EdgeInsets.only(left: toDouble),
      child: this,
    );
  }

  Padding paddingRight(double toDouble) {
    return Padding(
      padding: EdgeInsets.only(right: toDouble),
      child: this,
    );
  }

  Padding paddingTop(double toDouble) {
    return Padding(
      padding: EdgeInsets.only(top: toDouble),
      child: this,
    );
  }

  Padding paddingBottom(double toDouble) {
    return Padding(
      padding: EdgeInsets.only(bottom: toDouble),
      child: this,
    );
  }

  Center centerX() {
    return Center(
      child: this,
    );
  }
}
