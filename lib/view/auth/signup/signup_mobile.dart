part of 'signup_view.dart';

class SignupMobile extends StatelessWidget {
  final SignupViewModel viewModel;
  final SignupBody body;
  const SignupMobile({super.key, required this.viewModel, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return Scaffold(
          appBar: body.buildAppBar(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: body.buildAnimastion(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        context.mySubheadingText(text: 'SIGN UP'),
                        SizedBox(
                          height: context.padding,
                        ),
                        body.signUpForm(context),
                        SizedBox(
                          height: context.largePadding,
                        ),
                        body.buildSignupButton(context),
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
