import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class LimitsView extends StatefulWidget {
  const LimitsView({super.key});

  @override
  State<LimitsView> createState() => _LimitsViewState();
}

class _LimitsViewState extends State<LimitsView> {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container();
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Container();
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Row(
            children: [
              context.mySubheadingText(
                  text: 'Limits', textAlign: TextAlign.center)
            ],
          ).paddingOnly(bottom: context.padding),
          _myLimitCard("Staff Limit", "25", "50")
              .paddingBottom(context.padding),
          _myLimitCard("Regions Limit", "25", "50")
              .paddingBottom(context.padding),
          _myLimitCard("Warehouses Limit", "25", "50")
              .paddingBottom(context.padding),
          _myLimitCard("Products Limit", "25", "50"),
        ],
      ).paddingAll(context.padding),
    );
  }

  Widget _myLimitCard(
    String title,
    String limitMax,
    String currentLimit,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(context.borderRadius),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              context.myText(text: title),
              const Spacer(),
              context.mySmallText(text: "$currentLimit/$limitMax"),
            ],
          ).paddingBottom(context.smallPadding),
          const LinearProgressIndicator(
            value: 0.5,
          ),
        ],
      ).paddingAll(context.smallPadding),
    );
  }
}
