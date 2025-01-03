import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class RegionsView extends StatefulWidget {
  const RegionsView({super.key});

  @override
  State<RegionsView> createState() => _RegionsViewState();
}

class _RegionsViewState extends State<RegionsView> {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  //--------------------------------------------------------------------------------
  Widget _addRegions() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _regionsDetails() {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Regions',
              style: TextStyle(
                fontSize: context.bodySize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).paddingLeft(context.smallPadding),
        ],
      ),
    );
  }

  Widget _regionsGridList() {
    return SizedBox(
      height: context.cardHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          context.responsiveGridView(
            crossAxiscount: 1,
            padding: EdgeInsets.all(context.smallPadding),
            childAspectRatio: 1,
            children: List.generate(
              10,
              (index) {
                return context.myCard(
                  onTap: () {},
                  title: 'Card',
                  subtitle: 'Subtitle',
                  icon: Icons.location_city,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  //--------------------------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildTabletLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 12,
            child: Column(
              children: [
                Row(
                  children: [
                    context
                        .mySubheadingText(text: 'Regions')
                        .paddingLeft(context.smallPadding),
                    const Spacer(),
                    _addRegions().paddingRight(context.smallPadding),
                  ],
                ),
                _regionsGridList(),
                Expanded(
                  child: _regionsDetails().paddingAll(context.smallPadding),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
