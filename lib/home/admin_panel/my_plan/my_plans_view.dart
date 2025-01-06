import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class MyPlansView extends StatefulWidget {
  const MyPlansView({super.key});

  @override
  State<MyPlansView> createState() => _MyPlansViewState();
}

class _MyPlansViewState extends State<MyPlansView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return context.responsiveWrapper(
          small: _buildMobileLayout(context, size),
          medium: _buildTabletLayout(context, size),
          large: _buildDesktopLayout(context, size),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, BoxConstraints size) {
    return const Scaffold();
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints size) {
    return const Scaffold();
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints size) {
    return Container(
      width: size.maxWidth * 0.75,
      height: size.maxHeight * 0.75,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(
          Radius.circular(context.borderRadius),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              context.mySubheadingText(
                  text: 'My Plans', textAlign: TextAlign.center),
            ],
          ).paddingAll(context.smallPadding),
          Expanded(
            child: Container(
              width: size.maxWidth,
              height: size.maxHeight,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.all(
                  Radius.circular(context.borderRadius),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.mySubheadingText(text: "Max"),
                  Center(
                    child: context.mySubheadingText(
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
                  const Spacer(),
                  Center(
                    child: context.myButton(
                      buttonText: 'Upgrade Now',
                      onPressed: () {},
                    ),
                  ),
                ],
              ).paddingAll(context.smallPadding),
            ).paddingAll(context.smallPadding),
          ),
        ],
      ).paddingAll(context.smallPadding),
    );
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
