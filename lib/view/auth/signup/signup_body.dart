part of 'signup_view.dart';

class SignupBody extends SignupViewModel {
  Widget buildAnimastion(BuildContext context) {
    return Lottie.asset(
      'assets/animation/auth/register.json',
      fit: BoxFit.cover,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          context.mySubheadingText(text: 'JOIN US!'),
        ],
      ),
    );
  }

  Widget signUpForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          context
              .myTextFormField(
                controller: companyNameController,
                labelText: 'Şirket Adı',
                hintText: 'Şirket Adı Giriniz',
                validator: companyNameValidator,
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
          ValueListenableBuilder(
            valueListenable: isVisible,
            builder: (context, value, _) {
              return context
                  .myTextFormField(
                    obscureText: value,
                    controller: passController,
                    labelText: 'Şifre',
                    hintText: 'Şifre Giriniz',
                    validator: passwordValidator,
                    prefixIcon: Icons.lock_open,
                    suffixIcon: IconButton(
                      icon:
                          Icon(value ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        isVisible.value = !isVisible.value;
                      },
                    ),
                  )
                  .paddingVertical(context.smallPadding);
            },
          ),
          ValueListenableBuilder(
            valueListenable: isVisibleConfirm,
            builder: (context, value, _) {
              return context
                  .myTextFormField(
                    obscureText: value,
                    controller: passConfirmController,
                    labelText: 'Şifre Doğrulama',
                    hintText: 'Şifre Giriniz',
                    validator: passwordConfirmValidator,
                    prefixIcon: Icons.lock_open,
                    suffixIcon: IconButton(
                      icon:
                          Icon(value ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        isVisibleConfirm.value = !isVisibleConfirm.value;
                      },
                    ),
                  )
                  .paddingVertical(context.smallPadding);
            },
          ),
        ],
      ),
    );
  }

  Widget buildSignupButton(BuildContext context) {
    return context.myButton(
      height: context.buttonHeight,
      width: MediaQuery.of(context).size.width,
      buttonText: 'SIGN UP',
      onPressed: () => signup(),
    );
  }
}
