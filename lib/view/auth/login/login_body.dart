part of 'login_view.dart';

class LoginBody extends LoginViewModel {
  //----------------------------------------------------------------------------
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
        RouteManager.navigateTo(context, RouteConstants.signup);
      },
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          context
              .myTextFormField(
                controller: companyCodeController,
                labelText: 'Şirket Kodu',
                hintText: 'Şirket Kodu Giriniz',
                validator: companyCodeValidator,
                prefixIcon: Icons.business,
              )
              .paddingVertical(context.smallPadding),
          context
              .myTextFormField(
                controller: emailController,
                labelText: 'Email',
                hintText: 'Email Giriniz',
                validator: emailValidator,
                prefixIcon: Icons.email,
              )
              .paddingVertical(context.smallPadding),
          context
              .myTextFormField(
                obscureText: isVisible.value,
                controller: passwordController,
                labelText: 'Şifre',
                hintText: 'Şifre Giriniz',
                validator: passwordValidator,
                prefixIcon: Icons.lock_open,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: isVisible.value
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              )
              .paddingVertical(context.smallPadding),
        ],
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return context.myButton(
      height: context.buttonHeight,
      width: MediaQuery.of(context).size.width,
      buttonText: 'LOGIN',
      onPressed: () {
        RouteManager.navigateToReplacement(context, RouteConstants.home);
        //login();
      },
    );
  }
}
