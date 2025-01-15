import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Abstract base class for creating responsive drawers
abstract class BaseDrawer extends StatefulWidget {
  const BaseDrawer({
    required Key key,
    this.backgroundColor,
    this.width,
    this.elevation,
    this.shape,
    this.drawerMode = DrawerMode.icon,
  }) : super(key: key);

  final DrawerMode drawerMode;
  final Color? backgroundColor;
  final double? width;
  final double? elevation;
  final ShapeBorder? shape;

  /// Build the header section of the drawer
  Widget buildDrawerHeader(BuildContext context);

  /// Build the body section of the drawer
  Widget buildDrawerBody(BuildContext context);

  /// Build the footer section of the drawer
  Widget buildDrawerFooter(BuildContext context);

  @override
  State<BaseDrawer> createState() => _BaseDrawerState();
}

class _BaseDrawerState extends State<BaseDrawer> {
  late DrawerMode _currentDrawerMode;
  late ValueNotifier<double> _drawerWidth;

  @override
  void initState() {
    super.initState();
    _currentDrawerMode = widget.drawerMode;
    _drawerWidth = ValueNotifier(widget.width ?? _currentDrawerMode.width);
  }

  @override
  void didUpdateWidget(BaseDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.drawerMode != widget.drawerMode) {
      _currentDrawerMode = widget.drawerMode;
      _drawerWidth.value = widget.width ?? _currentDrawerMode.width;
    }
  }

  @override
  void dispose() {
    _drawerWidth.dispose();
    super.dispose();
  }

  void changeMode() {
    if (_currentDrawerMode == DrawerMode.icon) {
      _currentDrawerMode = DrawerMode.detail;
      _drawerWidth.value = _currentDrawerMode.width;
    }
  }

  DrawerMode get currentMode => _currentDrawerMode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _drawerWidth,
      builder: (context, width, child) {
        return Drawer(
          backgroundColor:
              widget.backgroundColor ?? context.drawerTheme.backgroundColor,
          width: width,
          elevation: widget.elevation ?? context.drawerTheme.elevation,
          shape: widget.shape,
          child: SafeArea(
            child: Column(
              children: [
                IconButton(
                    onPressed: () => changeMode(), icon: Icon(Icons.menu)),
                // --
                widget.buildDrawerHeader(context),
                Expanded(
                  child: widget.buildDrawerBody(context),
                ),
                widget.buildDrawerFooter(context),
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:widgets/widgets.dart';

// abstract class BaseDrawerView extends StatelessWidget {
//   final ChangeNotifier notifier;
//   const BaseDrawerView({
//     super.key,
//     required this.notifier,
//     required this.drawerMode,
//     this.backgroundColor,
//     this.width,
//     this.elevation,
//     this.shape,
//   });

//   final DrawerMode drawerMode;
//   final Color? backgroundColor;
//   final double? width;
//   final double? elevation;
//   final ShapeBorder? shape;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer();
//   }
// }
