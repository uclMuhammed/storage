import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets/widgets.dart';

import 'signup_view_model.dart';

part 'signup_desktop.dart';
part 'signup_mobile.dart';
part 'signup_tablet.dart';
part 'signup_body.dart';

class SignupView extends BaseView {
  final SignupViewModel viewModel;
  final SignupBody body;
  const SignupView({super.key, required this.viewModel, required this.body});

  @override
  Widget buildDesktopView(BuildContext context) {
    return SignupDesktop(viewModel: viewModel, body: body);
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return SignupMobile(viewModel: viewModel, body: body);
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return SignupDesktop(viewModel: viewModel, body: body);
  }
}
