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

          // Limits Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: context.padding,
              crossAxisSpacing: context.padding,
              children: [
                // Regions Limits
                _buildLimitCard(
                  context,
                  title: 'Regions Limits',
                  currentLimit: 10,
                  totalLimit: 20,
                ),

                // Warehouses Limits
                _buildLimitCard(
                  context,
                  title: 'Warehouses Limits',
                  currentLimit: 5,
                  totalLimit: 15,
                ),

                // Products Limits
                _buildLimitCard(
                  context,
                  title: 'Products Limits',
                  currentLimit: 15,
                  totalLimit: 50,
                ),
              ],
            ),
          ),
        ],
      ).paddingAll(context.padding),
    );
  }

  // Helper method to create a consistent limit card
  Widget _buildLimitCard(
    BuildContext context, {
    required String title,
    required int currentLimit,
    required int totalLimit,
  }) {
    double progressValue = currentLimit / totalLimit;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(context.borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          context.mySubheadingText(text: title),
          // Current Limit
          context
              .mySmallText(text: '$currentLimit / $totalLimit')
              .paddingAll(context.smallPadding),
          // Progress Indicator
          SizedBox(
            width: context.screenWidth * 0.2,
            child: LinearProgressIndicator(
              value: progressValue,
              borderRadius: BorderRadius.all(
                Radius.circular(context.borderRadius),
              ),
              semanticsLabel: '$title Progress',
              semanticsValue: progressValue.toString(),
            ),
          ),
        ],
      ).paddingAll(context.padding),
    );
  }
}
