import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget paddingOnly(
          {double left = 0,
          double top = 0,
          double right = 0,
          double bottom = 0}) =>
      Padding(
          padding: EdgeInsets.only(
              left: left, top: top, right: right, bottom: bottom),
          child: this);

  Widget paddingHorizontal(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  Widget paddingVertical(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  Widget paddingLeft(double value) =>
      Padding(padding: EdgeInsets.only(left: value), child: this);

  Widget paddingRight(double value) =>
      Padding(padding: EdgeInsets.only(right: value), child: this);

  Widget paddingTop(double value) =>
      Padding(padding: EdgeInsets.only(top: value), child: this);

  Widget paddingBottom(double value) =>
      Padding(padding: EdgeInsets.only(bottom: value), child: this);
}
