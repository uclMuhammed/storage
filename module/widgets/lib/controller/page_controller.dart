import 'package:flutter/material.dart';

class OnboardPageController extends ChangeNotifier {
  /// Current page index
  int _currentPage = 0;

  /// Page controller for onboard screen
  final PageController pageController = PageController(initialPage: 0);

  /// Get current page index
  int get currentPage => _currentPage;

  /// Update current page index
  void updatePage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  /// Navigate to next page
  void nextPage() {
    if (_currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Navigate to previous page
  void previousPage() {
    if (_currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Jump to specific page
  void jumpToPage(int page) {
    pageController.jumpToPage(page);
  }

  /// Animate to specific page
  void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Total number of pages in onboard screen
  final int totalPages;

  /// Constructor
  OnboardPageController({this.totalPages = 3});

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
