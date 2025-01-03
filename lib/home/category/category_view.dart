import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  //---------------------------------------------
  Widget _addCategory() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _addSubCategory() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _categoryGridList() {
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
                  title: 'Category Card',
                  subtitle: 'Subtitle',
                  icon: Icons.category,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _subCategoryGridList() {
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
                  title: 'SubCategory Card',
                  subtitle: 'Subtitle',
                  icon: Icons.category,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  //---------------------------------------------

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
                        .mySubheadingText(text: 'Categories')
                        .paddingLeft(context.smallPadding),
                    const Spacer(),
                    _addCategory().paddingRight(context.smallPadding),
                  ],
                ),
                _categoryGridList(),
                Row(
                  children: [
                    context
                        .mySubheadingText(text: 'Sub Categories')
                        .paddingLeft(context.smallPadding),
                    const Spacer(),
                    _addSubCategory().paddingRight(context.smallPadding),
                  ],
                ),
                _subCategoryGridList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
