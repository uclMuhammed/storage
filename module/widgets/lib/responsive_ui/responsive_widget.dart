import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:widgets/index.dart';

extension ResponsiveWidgetExtension on BuildContext {
// My Text
  Text mySubText({
    required String text,
    TextAlign? textAlign,
    int? maxLines,
    TextStyle? style,
    TextOverflow? overflow,
  }) =>
      Text(
        text,
        style: style ?? subTextStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text myText({
    required String text,
    TextAlign? textAlign,
    int? maxLines,
    TextStyle? style,
    TextOverflow? overflow,
  }) =>
      Text(
        text,
        style: style ?? bodyStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text mySmallText({
    required String text,
    TextAlign? textAlign,
    int? maxLines,
    TextStyle? style,
    TextOverflow? overflow,
  }) =>
      Text(
        text,
        style: style ?? smallTextStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text myHeadingText({
    required String text,
    TextAlign? textAlign,
    int? maxLines,
    TextStyle? style,
    TextOverflow? overflow,
  }) =>
      Text(
        text,
        style: style ?? headingStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );

  Text mySubheadingText({
    required String text,
    TextAlign? textAlign,
    int? maxLines,
    TextStyle? style,
    TextOverflow? overflow,
  }) =>
      Text(
        text,
        style: style ?? subheadingStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
// My Line
  Widget myLine() => Container(
      height: 1,
      color: Theme.of(this).brightness == Brightness.light
          ? Colors.black
          : Colors.white);

  // Responsive Grid View

  Widget responsiveGridView({
    required List<Widget> children,
    double? childAspectRatio,
    required EdgeInsetsGeometry padding,
    required int crossAxisCount,
    Axis? scrollDirection,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      padding: padding,
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Tek sütun
        crossAxisSpacing: smallPadding,
        mainAxisSpacing: smallPadding,
        childAspectRatio: childAspectRatio ?? 1,
      ),
      scrollDirection: Axis.horizontal, // Yatay kaydırma
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  // My Button
  Widget myButton({
    required String buttonText,
    required VoidCallback onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
    Color? textColor,
  }) =>
      SizedBox(
        width: width ?? double.infinity,
        height: height ?? buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: elevatedButtonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            foregroundColor: WidgetStateProperty.all(textColor),
          ),
          child: Text(buttonText),
        ),
      );

  // My Text Button
  Widget myTextButton({
    required String buttonText,
    required Function() onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: textButtonStyle,
      child: Text(
        buttonText,
        style: smallTextStyle,
      ),
    );
  }

  // My Card
  Widget myCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    double? width,
    Function()? onTap,
  }) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width ?? cardWidth,
          decoration: cardDecoration.copyWith(
            color: backgroundColor,
          ),
          padding: padding ?? EdgeInsets.all(smallPadding),
          child: child,
        ).paddingAll(smallPadding / 2),
      ).paddingVertical(smallPadding / 2);

  // My Short Cut Button
  Widget myShortCutButton({
    required String name,
    required IconData icon,
    required Function() onTap,
    String? tooltipMessage = '',
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Tooltip(
        message: tooltipMessage,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          hoverColor: Colors.grey[800],
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                size: isLargeScreen ? smallIconSize : iconSize,
              ).paddingLeft(smallPadding),
              SizedBox(width: smallPadding),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: smallTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ).paddingHorizontal(isSmallScreen ? smallPadding : 0),
        ),
      ),
    );
  }

  // My Text Form Field
  Widget myTextFormField({
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool? obscureText,
    String? Function(String?)? validator,
    InputDecoration? decoration,
  }) =>
      TextFormField(
        controller: controller,
        style: bodyStyle,
        obscureText: obscureText ?? false,
        validator: validator,
        decoration: (decoration ?? inputDecoration).copyWith(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
        ),
      );

  Widget myLottie({
    required String path,
    double? width,
    double? height,
    BoxFit? fit,
    Widget? errorWidget,
  }) =>
      Lottie.asset(
        path,
        width: width ?? screenWidth * 0.8,
        height: height ?? screenHeight * 0.4,
        fit: fit ?? BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? const SizedBox.shrink();
        },
      );
}
