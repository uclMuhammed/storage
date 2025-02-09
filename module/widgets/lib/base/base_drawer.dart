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

  /// Build the button section of the drawer
  Widget buildDrawerButton(BuildContext context);

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
            shape: shape ??
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
            // -------------
            child: SafeArea(
              child: Column(
                children: [
                  buildDrawerButton(context),
                  const Divider(),
                  Expanded(
                    flex: 10,
                    child: buildDrawerBody(context),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 1,
                    child: buildDrawerFooter(context),
                  ),
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
      child: SizedBox(
        width: drawerNotifier.value.width,
        height: context.height > 800 ? context.height : 800,
        child: Stack(
          children: [
            child,
          ],
        ),
      ),
    );
  }
}
