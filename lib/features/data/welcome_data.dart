import '../../core/constants/string.dart';
import '../models/welcome_models.dart';

class WelcomeData {
  final List<WelcomeModel> welcomeModels;

  WelcomeData({required this.welcomeModels});

  static List<WelcomeModel> getWelcomeModels() {
    return [
      WelcomeModel(
        title: welcomeTitle1,
        description: welcomeDescription1,
        animationAsset: welcomeAnimation1,
      ),
      WelcomeModel(
        title: welcomeTitle2,
        description: welcomeDescription2,
        animationAsset: welcomeAnimation2,
      ),
      WelcomeModel(
        title: welcomeTitle3,
        description: welcomeDescription3,
        animationAsset: welcomeAnimation3,
      ),
    ];
  }
}
