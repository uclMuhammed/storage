import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

import '../routes/app_routes.dart';
import '../routes/navigation_service.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<WelcomePageData> pages = [
    WelcomePageData(
      title: 'Luxury and Comfort',
      description: 'Just a Tap Away',
      imageUrl: 'https://picsum.photos/800/1200?random=1',
    ),
    WelcomePageData(
      title: 'Easy to Use',
      description: 'Simple and User Friendly',
      imageUrl: 'https://picsum.photos/800/1200?random=2',
    ),
    WelcomePageData(
      title: 'Let\'s Start',
      description: 'Begin Your Journey',
      imageUrl: 'https://picsum.photos/800/1200?random=3',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return context.responsiveWrapper(
          small: _buildMobileScreen(context, size),
          medium: _buildTabletScreen(context, size),
          large: _buildDesktopScreen(context, size),
        );
      },
    );
  }

  Widget _buildMobileScreen(BuildContext context, BoxConstraints size) {
    return _buildDesktopScreen(context, size);
  }

  Widget _buildTabletScreen(BuildContext context, BoxConstraints size) {
    return _buildDesktopScreen(context, size);
  }

  Widget _buildDesktopScreen(BuildContext context, BoxConstraints size) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: pages.length,
            itemBuilder: (context, index) => _buildPage(pages[index], size),
          ),
          Row(
            children: [
              // Sol taraf
              if (context.isLargeScreen || context.isMediumScreen)
                Expanded(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: size.maxHeight,
                            width: size.maxWidth,
                            color: Colors.black87,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  context.mySubheadingText(
                                    text: "STOKLARIM.com",
                                  ),
                                  context.myHeadingText(
                                    text: "LOGO",
                                  ),
                                ],
                              ),
                            ),
                          ).paddingAll(context.smallPadding),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: size.maxHeight,
                            width: size.maxWidth,
                            color: Colors.black87,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                context.myText(
                                  text: '',
                                ),
                              ],
                            ),
                          ).paddingAll(context.smallPadding),
                        ),
                      ],
                    ),
                  ),
                ),
              // Sağ taraf
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pages.length,
                              (index) => _buildDot(index),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: context.myButton(
                              width: size.maxWidth,
                              height: context.buttonHeight,
                              color: _currentPage == pages.length - 1
                                  ? Colors.blueAccent
                                  : null,
                              buttonText: _currentPage == pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              onPressed: () {
                                if (_currentPage == pages.length - 1) {
                                  NavigationService.navigatorKey.currentState!
                                      .pushNamed(AppRoutes.login);
                                } else {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage(WelcomePageData page, BoxConstraints size) {
    return Stack(
      children: [
        // Arka plan resmi
        SizedBox(
          width: size.maxWidth,
          height: size.maxHeight,
          child: Image.network(
            page.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        // Karartma katmanı
        Container(
          width: size.maxWidth,
          height: size.maxHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black12,
                Colors.black38,
                Colors.black,
              ],
              stops: [0.0, 0.5, 0.9],
            ),
          ),
        ),
        // İçerik
        Positioned(
          bottom: 180,
          left: context.isLargeScreen || context.isMediumScreen
              ? size.maxWidth * 0.3
              : 20,
          right: context.isLargeScreen || context.isMediumScreen ? 80 : 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                page.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                page.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class WelcomePageData {
  final String title;
  final String description;
  final String imageUrl;

  WelcomePageData({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
