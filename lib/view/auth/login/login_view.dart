import 'package:backend/const/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets/widgets.dart';
import '../../../features/routes/routes.dart';
import 'login_view_model.dart';

part 'login_desktop.dart';
part 'login_mobile.dart';
part 'login_tablet.dart';
part 'login_body.dart';

class LoginView extends BaseView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) {
    return LoginDesktop();
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return LoginMobile();
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return LoginDesktop();
  }
}
