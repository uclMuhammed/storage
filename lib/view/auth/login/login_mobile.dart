part of 'login_view.dart';

class LoginMobile extends StatelessWidget {
  final LoginViewModel viewModel;
  final LoginBody body;
  LoginMobile({
    super.key,
  })  : viewModel = LoginViewModel()..init(),
        body = LoginBody(viewModel: LoginViewModel()..init());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: context.myHeadingText(text: 'WELCOME BACK'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Center(child: body.buildLoginAnimation(context))),
              Expanded(
                flex: 2,
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        context.mySubheadingText(text: 'LOG IN'),
                        SizedBox(
                          height: context.padding,
                        ),
                        body.buildLoginForm(context),
                        SizedBox(
                          height: context.smallPadding,
                        ),
                        body.buildLoginButton(context),
                        context.myLine().paddingVertical(context.smallPadding),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
