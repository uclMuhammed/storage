import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

part 'settings_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with SettingsViewModel, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return context.responsiveWrapper(
          small: _buildMobileLayout(context, constraints),
          medium: _buildTabletLayout(context, constraints),
          large: _buildDesktopLayout(context, constraints),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, BoxConstraints size) {
    return const Placeholder();
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints size) {
    return const Placeholder();
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              context
                  .mySubheadingText(
                      text: 'Settings', textAlign: TextAlign.center)
                  .paddingAll(context.smallPadding),
            ],
          ),
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                text: 'General Settings',
              ),
              Tab(
                text: 'Apps',
              ),
              Tab(
                text: 'Notifications',
              ),
              Tab(
                text: 'Plans',
              ),
              Tab(
                text: 'Security',
              ),
            ],
          ).paddingAll(context.smallPadding),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                generalSettingsView(),
                securitySettingsView(),
                securitySettingsView(),
                securitySettingsView(),
                securitySettingsView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generalSettingsView() {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              context
                  .myText(text: 'General Settings', textAlign: TextAlign.center)
                  .paddingAll(context.smallPadding),
            ],
          ),
        ],
      ),
    );
  }

  Widget securitySettingsView() {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              context
                  .myText(text: 'Security', textAlign: TextAlign.center)
                  .paddingAll(context.smallPadding),
            ],
          ),
        ],
      ),
    );
  }
}
