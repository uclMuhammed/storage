import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

abstract class BaseDrawerView extends StatelessWidget {
  final GenericNotifier<DrawerMode> drawerNotifier;
  final Color? backgroundColor;
  final double? width;
  final double? elevation;
  final ShapeBorder? shape;
  final Key viewKey;

  const BaseDrawerView({
    required this.viewKey,
    required this.drawerNotifier,
    this.backgroundColor,
    this.width,
    this.elevation,
    this.shape,
  }) : super(key: viewKey);

  /// Build the header section of the drawer
  Widget buildDrawerHeader(BuildContext context);

  /// Build the body section of the drawer
  Widget buildDrawerBody(BuildContext context);

  /// Build the footer section of the drawer
  Widget buildDrawerFooter(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DrawerMode>(
      valueListenable: drawerNotifier,
      builder: (context, mode, _) {
        // -------------
        return _ChildAnimated(
          drawerNotifier: drawerNotifier,
          // -------------
          child: Drawer(
            backgroundColor:
                backgroundColor ?? context.drawerTheme.backgroundColor,
            width: mode.width,
            elevation: elevation ?? context.drawerTheme.elevation,
            shape: shape ?? context.drawerTheme.shape,
            // -------------
            child: SafeArea(
              child: Column(
                children: [
                  // --
                  const SizedBox(height: 40),
                  // --
                  Expanded(
                    flex: 1,
                    child: buildDrawerHeader(context),
                  ),
                  const Divider(),
                  // --
                  Expanded(
                    flex: 5,
                    child: buildDrawerBody(context),
                  ),
                  const Divider(),
                  // --
                  Expanded(
                    flex: 1,
                    child: buildDrawerFooter(context),
                  ),
                  //--
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChildAnimated extends StatelessWidget {
  const _ChildAnimated({required this.drawerNotifier, required this.child});
  final Widget child;
  final GenericNotifier<DrawerMode> drawerNotifier;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration300Ms,
      curve: Curves.easeInOut,
      width: drawerNotifier.value.width,
      // -------------
      child: SingleChildScrollView(
        child: SizedBox(
          width: drawerNotifier.value.width,
          height: context.height > 800 ? context.height : 800,
          child: Stack(
            children: [
              child,
              Positioned(
                height: 30,
                width: 30,
                top: 20,
                left: 0,
                right: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () => drawerNotifier.change(
                    drawerNotifier.value == DrawerMode.icon
                        ? DrawerMode.detail
                        : DrawerMode.icon,
                  ),
                  icon: Icon(
                    drawerNotifier.value == DrawerMode.icon
                        ? Icons.menu
                        : Icons.arrow_back,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
