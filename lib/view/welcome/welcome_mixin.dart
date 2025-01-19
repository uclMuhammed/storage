import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgets/base/base_view_model.dart';
import 'package:widgets/controller/welcome_page_controller.dart';
import 'package:widgets/widgets.dart';
import '../../../features/data/welcome_data.dart';
import '../../../features/models/welcome_models.dart';

class WelcomePageMixin extends BaseViewModel {
  final WelcomePageController controller = WelcomePageController();
  final List<WelcomeModel> welcomeModels = WelcomeData.getWelcomeModels();
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);

  Widget buildDot(int index) {
    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      },
    );
  }

  Widget buildAppTitle(BuildContext context) {
    return context.myHeadingText(
      text: 'STOKLARIM.com',
      textAlign: TextAlign.center,
    );
  }

  Widget buildTitleDescription() {
    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, _) {
        return context.myHeadingText(
          textAlign: TextAlign.center,
          text: welcomeModels[currentPage].title,
        );
      },
    );
  }

  Widget buildDescription() {
    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, _) {
        return context.mySubheadingText(
          textAlign: TextAlign.center,
          text: welcomeModels[currentPage].description,
        );
      },
    );
  }

  Widget buildWelcomePage() {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (index) {
        controller.updatePage(index);
        currentPageNotifier.value = index;
      },
      itemCount: controller.totalPages,
      itemBuilder: (context, index) {
        return buildWelcomeImage(context, index);
      },
    );
  }

  Widget buildNextPage(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, child) {
        final isLastPage = currentPage == controller.totalPages - 1;
        final isFirstPage = currentPage == 0;

        String buttonText;
        if (isLastPage) {
          buttonText = 'Bize Katıl';
        } else if (isFirstPage) {
          buttonText = 'Başlayalım';
        } else {
          buttonText = 'Sonraki';
        }

        return context.myButton(
          width: MediaQuery.of(context).size.width,
          height: context.buttonHeight,
          color: isLastPage ? Colors.blueAccent : null,
          buttonText: buttonText,
          onPressed: () {
            if (isLastPage) {
              // Giriş sayfasına yönlendirme
            } else {
              controller.nextPage();
            }
          },
        );
      },
    );
  }

  Widget buildWelcomeImage(BuildContext context, int index) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Lottie.asset(
            welcomeModels[index].animationAsset,
            errorBuilder: (context, error, stackTrace) {
              return context.mySubheadingText(text: 'Animation Error');
            },
          ).paddingAll(context.smallPadding),
        ),
      ],
    );
  }

  @override
  void init() {}
}
