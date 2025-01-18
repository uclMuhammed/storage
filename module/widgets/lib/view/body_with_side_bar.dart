import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class BodyWithSideBar extends StatelessWidget {
  const BodyWithSideBar({
    super.key,
    required this.sideBar,
    required this.body,
    this.status = SideBarStatus.left,
  });
  //
  final Widget sideBar;
  final Widget body;
  final SideBarStatus status;
  //
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          if (status == SideBarStatus.left) sideBar,
          Expanded(child: body),
          if (status == SideBarStatus.right) sideBar
        ],
      ),
    );
  }
}
