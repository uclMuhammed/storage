part of 'signup_view.dart';

class SignupDesktop extends StatelessWidget {
  final SignupViewModel viewModel;
  final SignupBody body;
  const SignupDesktop({super.key, required this.viewModel, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return Scaffold(
          body: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    body.buildAppBar(context),
                    Center(
                      child: SizedBox(
                        width: size.maxWidth * 0.4,
                        child: body.buildAnimastion(context),
                      ),
                    ),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  context.mySubheadingText(text: 'SIGN UP'),
                                ],
                              ),
                              SizedBox(height: context.padding),
                              body.signUpForm(context),
                              SizedBox(height: context.smallPadding),
                              body.buildSignupButton(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).paddingAll(context.smallPadding),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
