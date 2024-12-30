import 'package:flutter/material.dart';
import 'package:storage/auth/auth_manager/auth_manager.dart';
import 'package:storage/routes/app_routes.dart';
import 'package:widgets/index.dart';

part 'signup_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> with SignupViewModel {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
        small: _mobileLayout(context),
        medium: _tabletLayout(context),
        large: _desktopLayout(context));
  }

//----------------------------------------------------------------------------
  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
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
      width: context.cardWidth * scale,
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
      'SIGNUP',
      style: TextStyle(
        fontSize: context.subheadingSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Form _formField(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          context.myTextFormField(
            title: 'Company Name',
            label: 'Company Name',
            hint: 'Company Name giriniz',
            controller: companyNameController,
            validator: companyNameValidator,
            prefixIcon: Icons.person,
          ),
          context.myTextFormField(
            title: 'E-Mail',
            label: 'E-Mail',
            hint: 'E-Mail giriniz',
            controller: emailController,
            validator: emailValidator,
            prefixIcon: Icons.email,
          ),
          context.myTextFormField(
            title: 'Password',
            label: 'Password',
            hint: 'Password giriniz',
            controller: passwordController,
            validator: passwordValidator,
            prefixIcon: Icons.lock,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              padding: EdgeInsets.symmetric(horizontal: context.smallPadding),
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
          context.myTextFormField(
            title: 'Re-Password',
            label: 'Re-Password',
            hint: 'Re-Password giriniz',
            controller: confirmPasswordController,
            validator: confirmPasswordValidator,
            prefixIcon: Icons.lock,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              padding: EdgeInsets.symmetric(horizontal: context.smallPadding),
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return context.myButton(
      color: Colors.blueAccent,
      buttonText: 'Signup',
      onPressed: () => signup(context),
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
              color: Colors.black,
              child: Column(
                children: [
                  _appBar(context),
                  _buildLogo(context).paddingAll(context.padding),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    'Stoklarınızı kontrol etmek',
                    style: TextStyle(
                        fontSize: context.subheadingSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'artık çok kolay.',
                    style: TextStyle(
                      fontSize: context.subheadingSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    'Tüm depolarınızı ve ürünlerinizi tek bir yerden yönetin.',
                    style: TextStyle(
                      fontSize: context.bodySize,
                      fontWeight: FontWeight.bold,
                    ),
                  ).paddingAll(context.padding),
                  const Spacer(
                    flex: 1,
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
