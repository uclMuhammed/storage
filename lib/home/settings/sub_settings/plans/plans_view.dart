import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class PlansView extends StatelessWidget {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              context
                  .myText(text: 'Plans', textAlign: TextAlign.center)
                  .paddingAll(context.smallPadding),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                _buildPlanBox(context),
                _buildPlanBox(context),
                _buildPlanBox(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildPlanBox(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.mySubheadingText(
                    text: 'Free', textAlign: TextAlign.center),
                context.myText(
                    text: 'Free For Test User', textAlign: TextAlign.center),
              ],
            ).paddingAll(context.smallPadding),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Center(
                  child: context.myHeadingText(
                    text: "£2.99",
                    textAlign: TextAlign.center,
                  ),
                ),
                planText(
                  '100 Kullanıcıya kadar destekler.',
                  context,
                ),
                planText(
                  '100 Depo Olusturabilirsin.',
                  context,
                ),
                planText(
                  '100 Ürün Ekleyebilirsin.',
                  context,
                ),
                planText(
                  '100 Bölge Ekleyebilirsin.',
                  context,
                ),
              ],
            ),
          ),
        ],
      ),
    ).paddingAll(context.smallPadding));
  }

  Widget planText(String text, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '✓ ',
                  style: TextStyle(
                    fontSize: context.smallTextSize,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: context.smallTextSize,
                  ),
                ),
              ],
            ),
          ).paddingAll(context.smallPadding),
        ),
      ],
    );
  }
}
