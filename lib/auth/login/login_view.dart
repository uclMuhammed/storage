import 'package:flutter/material.dart';
import 'package:widgets/index.dart';
import '../../routes/app_routes.dart';
import '../../routes/navigation_service.dart';
import '../auth_manager/auth_manager.dart';
part 'login_view_model.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewModel<LoginView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return context.responsiveWrapper(
          small: _buildMobileLayout(context, constraints),
          medium: _buildTabletLayout(context, constraints),
          large: _buildDesktopLayout(context, constraints),
        );
      },
    );
  }

  //----------------------------------------------------------------------------
  Form _formList() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          context.myTextFormField(
            controller: companyCodeController,
            hint: 'Sirket Kodu giriniz',
            label: 'Sirket Kodu',
            title: 'Sirket Kodu',
            validator: companyCodeValidator,
            prefixIcon: Icons.code,
          ),
          context.myTextFormField(
            controller: emailController,
            hint: 'E-posta giriniz',
            label: 'E-posta',
            title: 'E-posta',
            validator: emailValidator,
            prefixIcon: Icons.email,
          ),
          context
              .myTextFormField(
                obscureText: obscurePassword,
                controller: passwordController,
                hint: 'Sifre giriniz',
                label: 'Sifre',
                title: 'Sifre',
                validator: passwordValidator,
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.smallPadding),
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              )
              .paddingBottom(context.padding),
          context.myButton(
            buttonText: 'Giris Yap',
            onPressed: () => login(context),
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
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

  Widget _lowerAreaMobil(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            context.myTextButton(
              buttonText: 'Sifremi Unuttum',
              onPressed: () {},
            ),
          ],
        ).paddingAll(context.smallPadding),
        context.myLine(),
        context
            .myTextButton(
              buttonText: 'Hesabınız yok mu? Kayıt Ol.',
              onPressed: () {
                NavigationService.navigatorKey.currentState!
                    .pushNamed(AppRoutes.signup);
              },
            )
            .paddingAll(context.smallPadding),
      ],
    );
  }
  //----------------------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              context
                  .mySubheadingText(text: 'LOGIN', textAlign: TextAlign.center)
                  .paddingAll(context.smallPadding),
              _formList(),
              _lowerAreaMobil(context),
            ],
          ).paddingAll(context.padding),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            width: size.maxWidth * 0.75,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(context.borderRadius),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context
                      .mySubheadingText(
                          text: 'LOGIN', textAlign: TextAlign.center)
                      .paddingAll(context.smallPadding),
                  _formList(),
                  _lowerAreaMobil(context),
                ],
              ).paddingAll(context.padding),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Left Side -------------------------------------------------------
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        context
                            .mySubheadingText(text: 'STOKLARIM.com')
                            .paddingAll(context.smallPadding),
                      ],
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                          color: Colors.white24,
                          child: Center(
                            child: context
                                .mySubheadingText(text: 'Logo or something...')
                                .paddingAll(context.padding),
                          )),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: context
                              .mySubheadingText(
                                text:
                                    'this area for description like this. this area for description like this.',
                                textAlign: TextAlign.center,
                              )
                              .paddingAll(context.padding),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        context.myTextButton(
                          buttonText: 'Hesabınız yok mu? Kayıt Ol.',
                          onPressed: () {
                            NavigationService.navigatorKey.currentState!
                                .pushNamed(AppRoutes.signup);
                          },
                        ),
                      ],
                    ).paddingAll(context.smallPadding),
                  ],
                ),
              ),
            ),
            // Left Side -------------------------------------------------------
            // -----------------------------------------------------------------
            // Right Side ------------------------------------------------------
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.maxWidth * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius:
                            BorderRadius.circular(context.borderRadius),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          context.mySubheadingText(
                            text: 'LOGIN',
                            textAlign: TextAlign.center,
                          ),
                          _formList(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              context.myTextButton(
                                buttonText: 'Sifremi Unuttum',
                                onPressed: () {},
                              ),
                            ],
                          ).paddingAll(context.smallPadding),
                        ],
                      ).paddingAll(context.smallPadding),
                    ),
                  ],
                ),
              ),
            ),
            // Right Side ------------------------------------------------------
          ],
        ),
      ),
    );
  }
}
