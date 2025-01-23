import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

extension ResponsiveStyleExtension on BuildContext {
  // Heading styles
  TextStyle get largeHeadingStyle => TextStyle(
        fontSize: largeHeadingSize,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      );

  TextStyle get headingStyle => TextStyle(
        fontSize: headingSize,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      );

  TextStyle get subheadingStyle => TextStyle(
        fontSize: subheadingSize,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      );

  TextStyle get subTextStyle => TextStyle(
        fontSize: subTextSize,
        overflow: TextOverflow.clip,
      );

  // Body styles
  TextStyle get bodyStyle => TextStyle(
        fontSize: bodySize,
        overflow: TextOverflow.clip,
      );

  TextStyle get smallTextStyle => TextStyle(
        fontSize: smallTextSize,
        overflow: TextOverflow.clip,
      );

  // Button styles
  ButtonStyle get elevatedButtonStyle => ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: bodySize, fontWeight: FontWeight.bold),
        padding:
            EdgeInsets.symmetric(vertical: smallPadding, horizontal: padding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smallBorderRadius),
        ),
      );

  ButtonStyle get textButtonStyle => TextButton.styleFrom(
        textStyle: TextStyle(
          fontSize: bodySize,
        ),
      );

  // Input decoration
  InputDecoration get inputDecoration => InputDecoration(
        contentPadding: EdgeInsets.all(smallPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(smallBorderRadius),
        ),
        labelStyle: TextStyle(
          fontSize: smallTextSize,
        ),
        hintStyle: TextStyle(
          fontSize: smallTextSize,
        ),
      );

  // Card styles
  BoxDecoration get cardDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      );
}
