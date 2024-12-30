import 'package:flutter/material.dart';
import 'package:storage/routes/app_routes.dart';
import 'package:widgets/index.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  Widget _buildCommonContent(BuildContext context, {bool isDesktop = false}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo Section
          Container(
            width: isDesktop ? context.cardWidth : double.infinity,
            height: isDesktop ? context.cardHeight : 200,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(context.borderRadius),
            ),
            child: Center(
              child: context
                  .mySubheadingText(
                    text: 'Logo or something...',
                    textAlign: TextAlign.center,
                  )
                  .paddingAll(context.padding),
            ),
          ).paddingAll(context.padding),

          // Action Buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              context
                  .myButton(
                    color: Colors.blueAccent,
                    buttonText: 'Giriş Yap',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                  )
                  .paddingTop(context.largePadding),
              context
                  .myButton(
                    buttonText: 'Kayıt Ol',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                  )
                  .paddingTop(context.smallPadding),
            ],
          ).paddingAll(context.padding),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: _buildCommonContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: context.screenWidth * 0.75,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(context.borderRadius),
          ),
          child: _buildCommonContent(context),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side Information
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                      ),
                      child: Center(
                        child: context
                            .mySubheadingText(
                              text: 'Logo or something...',
                              textAlign: TextAlign.center,
                            )
                            .paddingAll(context.padding),
                      ),
                    ).paddingAll(context.padding),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                      ),
                      child: Center(
                        child: context
                            .mySmallText(
                              text:
                                  'Depolarınızı kontrol etmek artık çok kolay!. \n\nHesabınız yok mu? Kayıt Ol.',
                              textAlign: TextAlign.center,
                            )
                            .paddingAll(context.padding),
                      ),
                    ).paddingAll(context.padding),
                  ),
                ],
              ),
            ),
          ),
          // Right Side Login/Signup
          Expanded(
            flex: 8,
            child: Center(
              child: Container(
                width: context.cardWidth,
                child: _buildCommonContent(context, isDesktop: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
