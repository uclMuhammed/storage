import 'package:fl_chart/fl_chart.dart';
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

  // bodyDetailRow
  Widget bodyDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: context.iconSize),
        SizedBox(width: context.smallPadding),
        context.mySubText(
          text: '$label:  ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        context.mySubText(
          text: value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: valueColor,
            fontSize: context.subTextSize,
          ),
        ),
      ],
    ).paddingVertical(context.smallPadding / 1.5);
  }

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
    double? borderRadius,
    bool? isOutlined,
    Color? borderColor,
    TextStyle? textStyle,
    double? iconSize,
    Color? iconColor,
  }) =>
      SizedBox(
        width: width ?? double.infinity,
        height: height ?? buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: elevatedButtonStyle.copyWith(
            minimumSize: WidgetStateProperty.all(
                Size(width ?? double.infinity, height ?? buttonHeight)),
            maximumSize: WidgetStateProperty.all(
                Size(width ?? double.infinity, height ?? buttonHeight)),
            iconColor: WidgetStateProperty.all(iconColor),
            iconSize: WidgetStateProperty.all(iconSize),
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            foregroundColor: WidgetStateProperty.all(textColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? smallBorderRadius),
                side: isOutlined == true
                    ? BorderSide(color: borderColor ?? Colors.transparent)
                    : BorderSide.none,
              ),
            ),
          ),
          child: Text(
            buttonText,
            style: textStyle ?? smallTextStyle,
          ),
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
    double? height,
    Function()? onTap,
  }) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width ?? cardWidth,
          height: height ?? cardHeight,
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
    DrawerMode? drawerMode,
    String? tooltipMessage = '',
  }) {
    return Tooltip(
      message: tooltipMessage,
      child: SizedBox(
        height: 50,
        child: InkWell(
          borderRadius: BorderRadius.circular(smallBorderRadius),
          hoverColor: Colors.grey[800],
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                size: isLargeScreen ? smallIconSize : iconSize,
              ).paddingLeft(smallPadding),
              SizedBox(width: smallPadding / 2),
              Flexible(
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
          ),
        ),
      ),
    );
  }

  /* */

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
    TextStyle? style,
  }) =>
      TextFormField(
        controller: controller,
        style: style ?? bodyStyle,
        obscureText: obscureText ?? false,
        validator: validator,
        decoration: (decoration ?? inputDecoration).copyWith(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
        ),
      );

  // My Dropdown Button Form Field
  Widget myDropdownButtonFormField<T>({
    required String labelText,
    String? hintText,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
    T? value,
    String? Function(T?)? validator,
    InputDecoration? decoration,
    IconData? prefixIcon,
    Widget? suffixIcon,
    TextStyle? style,
  }) =>
      DropdownButtonFormField<T>(
        value: value,
        style: style ?? bodyStyle,
        decoration: (decoration ?? inputDecoration).copyWith(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
        ),
        items: items,
        onChanged: onChanged,
        validator: validator,
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

  // My Bar Chart

  BarChart myBarChart(BuildContext context,
      {required double maxY,
      required List<BarChartGroupData> barChartGroupData}) {
    return BarChart(
      BarChartData(
        maxY: maxY,
        barGroups: barChartGroupData,
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return context.mySmallText(text: 'Jan');
                  case 1:
                    return context.mySmallText(text: 'Feb');
                  case 2:
                    return context.mySmallText(text: 'Mar');
                  case 3:
                    return context.mySmallText(text: 'Apr');
                  case 4:
                    return context.mySmallText(text: 'May');
                  case 5:
                    return context.mySmallText(text: 'Jun');
                  case 6:
                    return context.mySmallText(text: 'Jul');
                  case 7:
                    return context.mySmallText(text: 'Aug');
                  case 8:
                    return context.mySmallText(text: 'Sep');
                  case 9:
                    return context.mySmallText(text: 'Oct');
                  case 10:
                    return context.mySmallText(text: 'Nov');
                  case 11:
                    return context.mySmallText(text: 'Dec');
                  default:
                    return context.mySmallText(text: 'not supported');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
