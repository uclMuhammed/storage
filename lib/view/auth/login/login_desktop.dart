part of 'login_view.dart';

class LoginDesktop extends StatelessWidget {
  final LoginViewModel viewModel;
  final LoginBody body;
  LoginDesktop({
    super.key,
  })  : viewModel = LoginViewModel()..init(),
        body = LoginBody(viewModel: LoginViewModel()..init());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return Scaffold(
          body: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    body.appBar(context),
                    Center(
                      child: SizedBox(
                        width: size.maxWidth * 0.4,
                        child: body.buildLoginAnimation(context),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          width: size.maxWidth * 0.4,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  context.mySubheadingText(text: 'LOG IN'),
                                ],
                              ),
                              SizedBox(
                                height: context.padding,
                              ),
                              body.buildLoginForm(context),
                              SizedBox(
                                height: context.smallPadding,
                              ),
                              body.buildLoginButton(context),
                              context
                                  .myLine()
                                  .paddingVertical(context.smallPadding),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  body.buildForgotPasswordButton(context),
                                ],
                              ),
                              SizedBox(
                                height: context.smallPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  body.buildSignUpButton(context),
                                ],
                              ),
                            ],
                          ).paddingAll(context.smallPadding),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
