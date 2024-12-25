import 'dart:ui';

import 'package:flutter/material.dart';

import 'responsive_ui.dart';

extension ResponsiveWidgetExtension on BuildContext {
  Widget myLine() => Container(height: 1, color: Colors.grey);

  /// Responsive Grid View
  Widget responsiveGridView({required List<Widget> children}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile
            ? 2
            : isTablet
                ? 3
                : 4,
        childAspectRatio: 1.5,
        crossAxisSpacing: padding,
        mainAxisSpacing: padding,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  /// My Button
  Widget myButton(
      {required String buttonText,
      required Function() onPressed,
      Color? color}) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color ?? Colors.blueAccent),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: bodySize),
        ),
      ),
    );
  }

  /// My Text Button
  Widget myTextButton(
      {required String buttonText, required Function() onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: bodySize),
      ),
    );
  }

  /// My Card
  Widget myCard({required String title, required String label}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: SizedBox(
        width: double.infinity,
        height: cardHeight + 80,
        child: Stack(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Icon(
                    Icons.warehouse,
                    size: largeIconSize,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.black45,
                  child: Padding(
                    padding: EdgeInsets.all(smallPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: headingSize,
                            ),
                          ),
                          Text(
                            label,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: bodySize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// My Short Cut Button
  Widget myShortCutButton(
      {required String name, required Icon icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        height: buttonHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: buttonHeight,
              height: buttonHeight,
              child: icon,
            ),
            SizedBox(width: padding),
            Expanded(
              flex: 1,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: subheadingSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// My Text Form Field
  Widget myTextFormField({
    String? title,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(title,
                style: TextStyle(
                    fontSize: subheadingSize, fontWeight: FontWeight.bold))
            : const SizedBox(height: 0),
        SizedBox(height: padding),
        TextFormField(
          controller: controller,
          style: TextStyle(fontSize: bodySize),
          validator: validator,
          decoration: InputDecoration(
            label: Text(
              label,
              style: TextStyle(
                fontSize: bodySize,
              ),
            ),
            hintStyle: TextStyle(
              fontSize: smallTextSize,
              color: Colors.grey,
            ),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                smallBorderRadius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
