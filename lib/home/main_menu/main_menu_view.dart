import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  MainMenuViewState createState() => MainMenuViewState();
}

class MainMenuViewState extends State<MainMenuView> {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

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
                      .mySubheadingText(text: 'Main Menu')
                      .paddingAll(context.smallPadding),
                ],
              ),
              SizedBox(
                height: 400,
                width: context.screenWidth,
                child: context.responsiveGridView(
                  padding: EdgeInsets.all(context.smallPadding),
                  crossAxiscount: 2,
                  childAspectRatio: 1,
                  children: [
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                    context.myCard(
                      onTap: () {},
                      title: 'Card',
                      subtitle: 'Subtitle',
                      icon: Icons.warehouse,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
