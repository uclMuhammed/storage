import '../const/index.dart';

enum DrawerMode {
  icon,
  detail,
  ;
  double get width => this == DrawerMode.icon ? drawerIconWidth : drawerDetailWidth;
}
