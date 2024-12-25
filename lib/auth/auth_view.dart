import 'package:flutter/material.dart';
import 'package:storage/auth/auth_manager/auth_manager.dart';
import 'package:storage/routes/app_routes.dart';
import 'package:widgets/index.dart';

part 'auth_view_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with AuthViewModel {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

//------------------------------------------------------------------------------
  Widget _buildLogo(BuildContext context, {double scale = 1.0}) {
    return Container(
      width: context.cardHeight * scale,
      height: context.cardHeight * scale,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(context.largeBorderRadius),
      ),
      child: Icon(Icons.warehouse, size: context.largeIconSize * scale),
    );
  }

  Widget _buildTitle(BuildContext context, {bool large = false}) {
    return Text(
      'Stoklarınızı takip etmek\nartık çok kolay.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: large ? context.headingSize : context.subheadingSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        context.myButton(
          buttonText: 'Giriş Yap',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
          color: Colors.blueAccent,
        ),
        SizedBox(height: context.padding),
        context.myButton(
          buttonText: 'Kayıt Ol',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
        ),
      ],
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'STOKLARIM',
        style: TextStyle(
          fontSize: context.headingSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  //------------------------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.padding),
          child: Column(
            children: [
              const Spacer(),
              _buildLogo(context),
              SizedBox(height: context.padding),
              _buildTitle(context),
              SizedBox(height: context.padding),
              Text(
                'Tüm depolarınızı ve ürünlerinizi tek bir yerden yönetin.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: context.bodySize),
              ),
              const Spacer(),
              _buildButtons(context),
              SizedBox(height: context.padding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(context, scale: 1.2),
                  SizedBox(height: context.padding),
                  _buildTitle(context),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(context.largePadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: _buildButtons(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(context, scale: 1.5),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(context.largePadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(context, large: true),
                    SizedBox(height: context.largePadding),
                    SizedBox(
                      width: 400,
                      child: _buildButtons(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
