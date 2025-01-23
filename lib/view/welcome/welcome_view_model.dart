import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';
import 'package:widgets/controller/welcome_page_controller.dart';
import '../../features/data/welcome_data.dart';
import '../../features/models/welcome_model.dart';

class WelcomeViewModel extends BaseViewModel {
  final WelcomePageController controller = WelcomePageController();
  final List<WelcomeModel> welcomeModels = WelcomeData.getWelcomeModels();
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);

  @override
  void init() {}
}
