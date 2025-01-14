import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

extension BoxConstraintsExtension on BoxConstraints {
  bool isMobile() {
    return maxWidth < 600;
  }

  bool isTablet() {
    return maxWidth >= 600 && maxWidth < 1024;
  }

  bool isDesktop() {
    return maxWidth >= 1024;
  }

  DeviceType getDeviceType() {
    if (isMobile()) {
      return DeviceType.mobile;
    } else if (isTablet()) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
}
