part of 'welcome_view.dart';

class WelcomeDesktop extends StatelessWidget {
  final WelcomePageMixin viewModel;
  const WelcomeDesktop({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.white),
                ),
              ),
              child: Column(
                children: [
                  viewModel.buildAppTitle(context),
                  context.myLine().paddingVertical(context.smallPadding),
                  Expanded(
                    child: Center(
                      child: viewModel.buildTitleDescription(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: viewModel.buildDescription(),
                  ),
                ],
              ).paddingAll(context.smallPadding),
            ),
          ),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                Expanded(child: viewModel.buildWelcomePage()),
                viewModel.buildNextPage(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    viewModel.welcomeModels.length,
                    (index) => viewModel.buildDot(index),
                  ),
                ).paddingAll(context.smallPadding),
              ],
            ).paddingAll(context.smallPadding),
          ),
        ],
      ),
    );
  }
}
