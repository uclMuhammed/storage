part of 'welcome_view.dart';

class WelcomeBody extends WelcomeViewModel {
  //--------------------------------------------------------------------------
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
    return context.mySubText(
      text: 'STOKLARIM.com',
      textAlign: TextAlign.center,
    );
  }

  Widget buildTitleDescription() {
    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, _) {
        return context.mySubText(
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
        return context.myText(
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
          buttonText: buttonText,
          onPressed: () {
            if (isLastPage) {
              routeController.navigatorKey.currentState
                  ?.pushNamedAndRemoveUntil(
                      Routes.login.routeName, (route) => false);
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
          child: context
              .myLottie(
                path: welcomeModels[index].animationAsset,
                errorWidget: context.myHeadingText(text: 'Animation Error'),
              )
              .paddingAll(context.smallPadding),
        ),
      ],
    );
  }
}
