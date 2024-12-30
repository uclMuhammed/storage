import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'platform_type.dart';

extension ResponsiveExtension on BuildContext {
  // Platform detection
  PlatformType get platformType {
    if (kIsWeb) {
      return PlatformType.web;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return PlatformType.mobile;
    } else {
      return PlatformType.desktop;
    }
  }

  // Platform specific values for status bar and bottom bar
  double get statusBarHeight {
    if (kIsWeb) return 0;
    if (Platform.isIOS) return 54;
    if (Platform.isAndroid) return 24;
    return 0;
  }

  double get bottomBarHeight {
    if (kIsWeb) return 0;
    if (Platform.isIOS) return 34;
    if (Platform.isAndroid) return 48;
    return 0;
  }

  // Screen size helpers
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // Screen size breakpoints
  bool get isSmallScreen => screenWidth < 600;
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 1024;
  bool get isLargeScreen => screenWidth >= 1024;

  // Platform specific UI values
  double get minWidth => switch (platformType) {
        PlatformType.mobile => 320,
        PlatformType.desktop => 1024,
        PlatformType.web => 768,
      };

  double get maxWidth => switch (platformType) {
        PlatformType.mobile => 768,
        PlatformType.desktop => 1920,
        PlatformType.web => 1440,
      };

  // Font sizes
  double get headingSize => isSmallScreen
      ? 22
      : isMediumScreen
          ? 26
          : 30;
  double get subheadingSize => isSmallScreen
      ? 18
      : isMediumScreen
          ? 22
          : 24;
  double get bodySize => isSmallScreen
      ? 14
      : isMediumScreen
          ? 16
          : 18;
  double get smallTextSize => isSmallScreen
      ? 12
      : isMediumScreen
          ? 14
          : 16;

  // Icon sizes
  double get iconSize => isSmallScreen
      ? 24
      : isMediumScreen
          ? 28
          : 32;
  double get smallIconSize => isSmallScreen
      ? 16
      : isMediumScreen
          ? 20
          : 24;
  double get largeIconSize => isSmallScreen
      ? 32
      : isMediumScreen
          ? 36
          : 40;

  // Height values
  double get buttonHeight => isSmallScreen
      ? 48
      : isMediumScreen
          ? 52
          : 56;
  double get inputHeight => isSmallScreen
      ? 40
      : isMediumScreen
          ? 44
          : 48;
  double get cardHeight => isSmallScreen
      ? 160
      : isMediumScreen
          ? 200
          : 240;

  // Width values
  double get maxContentWidth => isSmallScreen ? double.infinity : 1200;
  double get cardWidth => isSmallScreen
      ? screenWidth * 0.8
      : isMediumScreen
          ? 300
          : 360;

  // Padding values
  double get basePadding => switch (platformType) {
        PlatformType.mobile => 14,
        PlatformType.desktop => 18,
        PlatformType.web => 18,
      };

  double get padding => isSmallScreen
      ? basePadding
      : isMediumScreen
          ? basePadding * 1.5
          : basePadding * 2;
  double get smallPadding => padding / 2;
  double get largePadding => padding * 2;

  // Border radius values
  double get borderRadius => switch (platformType) {
        PlatformType.mobile => 8,
        PlatformType.desktop => 12,
        PlatformType.web => 10,
      };
  double get smallBorderRadius => borderRadius / 2;
  double get largeBorderRadius => borderRadius * 2;

  // Colors
  Color get backgroundColor => switch (platformType) {
        PlatformType.mobile => Colors.white,
        PlatformType.desktop => Colors.black87,
        PlatformType.web => Colors.white,
      };

  // Navigation values
  double get navigationBarHeight => switch (platformType) {
        PlatformType.mobile => 56,
        PlatformType.desktop => 64,
        PlatformType.web => 60,
      };

  // Content sizing
  double get contentWidth => isSmallScreen
      ? screenWidth * 0.9
      : isMediumScreen
          ? screenWidth * 0.75
          : screenWidth * 0.6;

  // Debug için ekran bilgilerini göster
  Widget showDebugInfo() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Screen Size: ${screenWidth.toStringAsFixed(0)} x ${screenHeight.toStringAsFixed(0)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            'Platform: ${platformType.toString()}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            'Device Type: ${isSmallScreen ? "Mobile" : isMediumScreen ? "Tablet" : "Desktop"}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Divider(color: Colors.white30, height: 20),
          Text(
            'Max Width: ${maxWidth.toStringAsFixed(0)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            'Padding: ${padding.toStringAsFixed(0)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            'Font Sizes - H:${headingSize.toStringAsFixed(0)} / B:${bodySize.toStringAsFixed(0)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
