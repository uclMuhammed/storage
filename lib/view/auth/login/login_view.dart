import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets/widgets.dart';
import '../../../features/routes/route_constants.dart';
import '../../../features/routes/route_manager.dart';
import 'login_view_model.dart';

part 'login_desktop.dart';
part 'login_mobile.dart';
part 'login_tablet.dart';
part 'login_body.dart';

class LoginView extends BaseView<LoginViewModel> {
  final LoginViewModel viewModel;
  final LoginBody body;
  const LoginView({super.key, required this.viewModel, required this.body});

  @override
  Widget buildDesktopView(BuildContext context) {
    return LoginDesktop(viewModel: viewModel, body: body);
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return LoginMobile(viewModel: viewModel, body: body);
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return LoginDesktop(viewModel: viewModel, body: body);
  }
}
