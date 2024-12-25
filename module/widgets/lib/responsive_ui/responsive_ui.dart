import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  // Screen size helpers
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // Breakpoints
  static const double kMobileBreakpoint = 600;
  static const double kTabletBreakpoint = 1024;

  // Device type checks
  bool get isMobile => screenWidth < kMobileBreakpoint;
  bool get isTablet =>
      screenWidth >= kMobileBreakpoint && screenWidth < kTabletBreakpoint;
  bool get isDesktop => screenWidth >= kTabletBreakpoint;

  // Padding values
  double get padding => switch (screenWidth) {
        < kMobileBreakpoint => 16,
        < kTabletBreakpoint => 24,
        _ => 32,
      };
  double get smallPadding => padding / 2;
  double get largePadding => padding * 2;

  // Font sizes
  double get headingSize => switch (screenWidth) {
        < kMobileBreakpoint => 22,
        < kTabletBreakpoint => 26,
        _ => 30,
      };
  double get subheadingSize => switch (screenWidth) {
        < kMobileBreakpoint => 18,
        < kTabletBreakpoint => 22,
        _ => 24,
      };
  double get bodySize => switch (screenWidth) {
        < kMobileBreakpoint => 14,
        < kTabletBreakpoint => 16,
        _ => 18,
      };
  double get smallTextSize => switch (screenWidth) {
        < kMobileBreakpoint => 12,
        < kTabletBreakpoint => 14,
        _ => 16,
      };

  // Height values
  double get buttonHeight => switch (screenWidth) {
        < kMobileBreakpoint => 48,
        < kTabletBreakpoint => 52,
        _ => 56,
      };
  double get inputHeight => switch (screenWidth) {
        < kMobileBreakpoint => 40,
        < kTabletBreakpoint => 44,
        _ => 48,
      };
  double get cardHeight => switch (screenWidth) {
        < kMobileBreakpoint => 160,
        < kTabletBreakpoint => 200,
        _ => 240,
      };

  // Width values
  double get maxContentWidth => isMobile ? double.infinity : 1200;
  double get cardWidth => switch (screenWidth) {
        < kMobileBreakpoint => screenWidth * 0.8,
        < kTabletBreakpoint => 300,
        _ => 360,
      };

  // Icon sizes
  double get iconSize => switch (screenWidth) {
        < kMobileBreakpoint => 24,
        < kTabletBreakpoint => 28,
        _ => 32,
      };
  double get smallIconSize => switch (screenWidth) {
        < kMobileBreakpoint => 16,
        < kTabletBreakpoint => 20,
        _ => 24,
      };
  double get largeIconSize => switch (screenWidth) {
        < kMobileBreakpoint => 32,
        < kTabletBreakpoint => 36,
        _ => 40,
      };

  // Border radius values
  double get borderRadius => switch (screenWidth) {
        < kMobileBreakpoint => 8,
        < kTabletBreakpoint => 12,
        _ => 16,
      };
  double get smallBorderRadius => borderRadius / 2;
  double get largeBorderRadius => borderRadius * 2;
}
