import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

extension ResponsiveWidgetExtension on BuildContext {
// My Text
  Text myText({required String text, TextAlign? textAlign}) => Text(
        text,
        style: bodyStyle,
        textAlign: textAlign,
        maxLines: 2,
      );
  Text mySmallText({required String text, TextAlign? textAlign}) => Text(
        text,
        style: smallTextStyle,
        textAlign: textAlign,
      );
  Text myHeadingText({required String text, TextAlign? textAlign}) => Text(
        text,
        style: headingStyle,
        textAlign: textAlign,
      );
  Text mySubheadingText({required String text, TextAlign? textAlign}) => Text(
        text,
        style: subheadingStyle,
        textAlign: textAlign,
      );
// My Line
  Widget myLine() => Container(height: 1, color: Colors.grey);

  // Responsive Grid View

  Widget responsiveGridView({
    required List<Widget> children,
    double? childAspectRatio,
    required EdgeInsetsGeometry padding,
    required int crossAxiscount,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      padding: padding,
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxiscount, // Tek sütun
        crossAxisSpacing: smallPadding,
        mainAxisSpacing: smallPadding,
        childAspectRatio: childAspectRatio ?? 1, // Çok uzun kartlar için
      ),
      scrollDirection: Axis.horizontal, // Yatay kaydırma
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  // My Button
  Widget myButton(
      {required String buttonText,
      required Function() onPressed,
      double? width,
      double? height,
      double? buttonHeight,
      Color? color}) {
    return SizedBox(
      width: width ?? buttonHeight,
      height: height ?? buttonHeight,
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

  // My Text Button
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

  // My Card
  Widget myCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Function() onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(smallBorderRadius),
      onTap: onTap,
      child: Card(
        child: Stack(
          children: [
            Center(child: Icon(icon, size: largeIconSize)),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: bodySize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: smallTextSize,
                  ),
                )
              ],
            ).paddingAll(smallPadding),
          ],
        ),
      ),
    );
  }

  // My Short Cut Button
  Widget myShortCutButton(
      {required String name,
      required IconData icon,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        name,
        style: TextStyle(
          fontSize: smallTextSize,
        ),
      ),
      onTap: onTap,
    );
  }

  // My Text Form Field
  Widget myTextFormField({
    String? title,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    required TextEditingController controller,
    InputDecoration? decoration,
    IconData? prefixIcon,
    IconButton? suffixIcon,
    bool? obscureText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title,
                style: TextStyle(
                  fontSize: bodySize,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox.shrink(),
        TextFormField(
          controller: controller,
          style: TextStyle(fontSize: bodySize),
          validator: validator,
          obscureText: obscureText ?? false,
          decoration: decoration ??
              InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.all(smallPadding),
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                suffixIcon: suffixIcon,
                labelText: label,
                labelStyle: TextStyle(
                  fontSize: smallTextSize,
                ),
                hintStyle: TextStyle(
                  fontSize: smallTextSize,
                  color: Colors.grey,
                ),
                hintText: hint ?? '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    smallBorderRadius,
                  ),
                ),
              ),
        ).paddingVertical(smallPadding),
      ],
    );
  }
}
