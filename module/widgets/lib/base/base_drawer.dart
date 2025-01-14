import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Abstract base class for creating responsive drawers
abstract class BaseDrawer extends StatelessWidget {
  const BaseDrawer({
    super.key,
    this.backgroundColor,
    this.width,
    this.elevation,
    this.shape,
    this.drawerMode = DrawerMode.icon,
  });

  final DrawerMode drawerMode;

  /// Background color of the drawer
  final Color? backgroundColor;

  /// Width of the drawer
  final double? width;

  /// Elevation of the drawer
  final double? elevation;

  /// Shape of the drawer
  final ShapeBorder? shape;

  /// Build the header section of the drawer
  Widget buildDrawerHeader(BuildContext context);

  /// Build the body section of the drawer
  Widget buildDrawerBody(BuildContext context);

  /// Build the footer section of the drawer
  Widget buildDrawerFooter(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor ?? context.drawerTheme.backgroundColor,
      width: drawerMode.width,
      elevation: elevation ?? context.drawerTheme.elevation,
      shape: shape,
      child: SafeArea(
        child: Column(
          children: [
            buildDrawerHeader(context),
            Expanded(
              child: buildDrawerBody(context),
            ),
            buildDrawerFooter(context),
          ],
        ),
      ),
    );
  }
}
