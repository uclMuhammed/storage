part of 'login_view.dart';

class LoginBody extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginBody({super.key, required this.viewModel});

  AppBar appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          context.mySubheadingText(text: 'WELCOME BACK'),
        ],
      ),
    );
  }

  Widget buildLoginAnimation(BuildContext context) {
    return Lottie.asset(
      'assets/animation/auth/login.json',
      width: context.isSmallScreen
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.5,
    );
  }

  Widget buildForgotPasswordButton(BuildContext context) {
    return context.myTextButton(
      buttonText: 'Şifremi Unuttum',
      onPressed: () {},
    );
  }

  Widget buildSignUpButton(BuildContext context) {
    return context.myTextButton(
      buttonText: 'Hesabınız yok mu? Kayıt Ol',
      onPressed: () {
        routeController.navigatorKey.currentState
            ?.pushNamed(Routes.register.routeName);
      },
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          context
              .myTextFormField(
                controller: viewModel.companyCodeController,
                labelText: 'Şirket Kodu',
                hintText: 'Şirket Kodu Giriniz',
                validator: viewModel.companyCodeValidator,
                prefixIcon: Icons.business,
              )
              .paddingVertical(context.smallPadding),
          context
              .myTextFormField(
                controller: viewModel.emailController,
                labelText: 'Email',
                hintText: 'Email Giriniz',
                validator: viewModel.emailValidator,
                prefixIcon: Icons.email,
              )
              .paddingVertical(context.smallPadding),
          ValueListenableBuilder(
            valueListenable: viewModel.isVisible,
            builder: (context, value, child) {
              return context
                  .myTextFormField(
                    obscureText: viewModel.isVisible.value,
                    controller: viewModel.passwordController,
                    labelText: 'Şifre',
                    hintText: 'Şifre Giriniz',
                    validator: viewModel.passwordValidator,
                    prefixIcon: Icons.lock_open,
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.isVisible.value = !viewModel.isVisible.value;
                      },
                      icon: viewModel.isVisible.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  )
                  .paddingVertical(context.smallPadding);
            },
          ),
        ],
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return context.myButton(
      height: context.buttonHeight,
      width: MediaQuery.of(context).size.width,
      buttonText: 'LOGIN',
      onPressed: () => viewModel.login(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildLoginAnimation(context),
        buildLoginForm(context),
        buildLoginButton(context),
        buildForgotPasswordButton(context),
        buildSignUpButton(context),
      ],
    );
  }
}
