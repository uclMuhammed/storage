import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

extension ResponsiveStyleExtension on BuildContext {
  TextStyle get headingStyle => TextStyle(
        fontSize: headingSize,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.fade,
      );
  TextStyle get subheadingStyle => TextStyle(
        fontSize: subheadingSize,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.fade,
      );
  TextStyle get bodyStyle => TextStyle(
        fontSize: bodySize,
        overflow: TextOverflow.fade,
      );
  TextStyle get smallTextStyle => TextStyle(
        fontSize: smallTextSize,
        overflow: TextOverflow.fade,
      );
}
