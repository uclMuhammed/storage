import 'package:flutter/material.dart';
import 'package:storage/auth/auth_manager/auth_manager.dart';
import 'package:storage/routes/app_routes.dart';
import 'package:widgets/index.dart';
part 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewModel {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      mobile: _mobileLayout(context),
      tablet: _tabletLayout(context),
      desktop: _desktopLayout(context),
    );
  }

  //----------------------------------------------------------------------------
  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        'STOKLARIM.com',
        style: TextStyle(
          fontSize: context.headingSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

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

  Text _title(BuildContext context) {
    return Text(
      'LOGIN',
      style: TextStyle(
        fontSize: context.headingSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Form _formField(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          context
              .myTextFormField(
                  title: 'Company Code',
                  label: 'Company Code',
                  hint: 'Company Code giriniz',
                  controller: companyCodeController,
                  validator: companyCodeValidator)
              .paddingTop(context.padding),
          context
              .myTextFormField(
                  title: 'E-Mail',
                  label: 'E-Mail',
                  hint: 'E-Mail giriniz',
                  controller: emailController,
                  validator: emailValidator)
              .paddingTop(context.padding),
          context
              .myTextFormField(
                  title: 'Password',
                  label: 'Password',
                  hint: 'Password giriniz',
                  controller: passwordController,
                  validator: passwordValidator)
              .paddingTop(context.padding),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return context.myButton(
      color: Colors.blueAccent,
      buttonText: 'Login',
      onPressed: login,
    );
  }

  Widget _lowerAreaMobil(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            context.myTextButton(
                buttonText: 'Sifremi Unuttum', onPressed: () {}),
          ],
        ).paddingAll(context.smallPadding),
        context.myLine().paddingAll(context.smallPadding),
        Center(
          child: context
              .myTextButton(
                buttonText: 'Hesabınız yok mu? Kayıt Ol.',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              )
              .paddingAll(context.smallPadding),
        ),
      ],
    );
  }

  //----------------------------------------------------------------------------

  Widget _mobileLayout(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title(context).paddingAll(context.smallPadding),
            _formField(context).paddingAll(context.padding),
            // Login Button
            _loginButton(context).paddingAll(context.padding),
            _lowerAreaMobil(context),
          ],
        ).paddingAll(context.padding),
      ),
    );
  }

  Widget _tabletLayout(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Container(
          width: context.screenWidth * 0.75,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(
              Radius.circular(context.borderRadius),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _title(context).paddingAll(context.smallPadding),
                _formField(context).paddingAll(context.smallPadding),
                _loginButton(context).paddingAll(context.smallPadding),
                _lowerAreaMobil(context),
              ],
            ).paddingAll(context.smallPadding),
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              width: context.screenWidth,
              height: context.screenHeight,
              color: Colors.blueAccent,
              child: Column(
                children: [
                  _appBar(context),
                  _buildLogo(context, scale: 1.5),
                  Text(
                    'Stoklarınızı kontrol etmek',
                    style: TextStyle(
                        fontSize: context.subheadingSize * 0.8,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'artık çok kolay.',
                    style: TextStyle(
                        fontSize: context.subheadingSize * 0.8,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tüm depolarınızı ve ürünlerinizi tek bir yerden yönetin.',
                    style: TextStyle(
                        fontSize: context.subheadingSize * 0.5,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    height: context.screenHeight * 0.05,
                    width: context.maxContentWidth,
                    color: Colors.black,
                    child: context.myTextButton(
                      buttonText: 'Hesabınız yok mu? Kayıt Ol.',
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.signup);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                width: context.screenWidth * 0.5,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.all(
                    Radius.circular(context.borderRadius),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _title(context).paddingAll(context.smallPadding),
                      _formField(context).paddingAll(context.smallPadding),
                      _loginButton(context).paddingAll(context.smallPadding),
                    ],
                  ).paddingAll(context.smallPadding),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
