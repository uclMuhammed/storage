part of 'login_view.dart';

class LoginTablet extends StatelessWidget {
  final LoginViewModel viewModel;
  final LoginBody body;
  LoginTablet({
    super.key,
  })  : viewModel = LoginViewModel()..init(),
        body = LoginBody(viewModel: LoginViewModel()..init());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
