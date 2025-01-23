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
  double get largeHeadingSize => isSmallScreen
      ? 32 // mobile
      : isMediumScreen
          ? 40 // tablet
          : 48; // desktop

  double get headingSize => isSmallScreen
      ? 24 // mobile
      : isMediumScreen
          ? 32 // tablet
          : 40; // desktop

  double get subheadingSize => isSmallScreen
      ? 20 // mobile
      : isMediumScreen
          ? 24 // tablet
          : 32; // desktop

  double get subTextSize => isSmallScreen
      ? 18 // mobile
      : isMediumScreen
          ? 20 // tablet
          : 24; // desktop

  double get bodySize => isSmallScreen
      ? 16 // mobile
      : isMediumScreen
          ? 18 // tablet
          : 20; // desktop

  double get smallTextSize => isSmallScreen
      ? 12 // mobile
      : isMediumScreen
          ? 14 // tablet
          : 16; // desktop

  // Icon sizes
  double get iconSize => isSmallScreen
      ? 24 // mobile
      : isMediumScreen
          ? 32 // tablet
          : 40; // desktop

  double get smallIconSize => isSmallScreen
      ? 20 // mobile
      : isMediumScreen
          ? 24 // tablet
          : 28; // desktop

  double get largeIconSize => isSmallScreen
      ? 32 // mobile
      : isMediumScreen
          ? 40 // tablet
          : 48; // desktop

  // Height values
  double get buttonHeight => isSmallScreen
      ? 40 // mobile
      : isMediumScreen
          ? 48 // tablet
          : 56; // desktop

  double get inputHeight => isSmallScreen
      ? 36 // mobile
      : isMediumScreen
          ? 44 // tablet
          : 52; // desktop

  double get cardHeight => isSmallScreen
      ? 180 // mobile
      : isMediumScreen
          ? 220 // tablet
          : 260; // desktop

  // Width values
  double get maxContentWidth => isSmallScreen ? double.infinity : 1200;

  double get cardWidth => isSmallScreen
      ? screenWidth * 0.9 // mobile
      : isMediumScreen
          ? 320 // tablet
          : 380; // desktop

  // Padding values
  double get basePadding => switch (platformType) {
        PlatformType.mobile => 12,
        PlatformType.desktop => 16,
        PlatformType.web => 16,
      };

  double get padding => isSmallScreen
      ? basePadding // mobile
      : isMediumScreen
          ? basePadding * 1.5 // tablet
          : basePadding * 2; // desktop

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
