part of 'welcome_view.dart';

class WelcomeMobile extends StatelessWidget {
  final WelcomePageMixin viewModel;
  const WelcomeMobile({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              viewModel.buildAppTitle(context).paddingAll(context.smallPadding),
            ],
          ),
          Expanded(
            child: viewModel.buildWelcomePage(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                viewModel
                    .buildTitleDescription()
                    .paddingVertical(context.smallPadding),
                viewModel
                    .buildDescription()
                    .paddingVertical(context.smallPadding),
                viewModel
                    .buildNextPage(context)
                    .paddingVertical(context.largePadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    viewModel.welcomeModels.length,
                    (index) => viewModel.buildDot(index),
                  ),
                ).paddingVertical(context.padding),
              ],
            ).paddingAll(context.smallPadding),
          ),
        ],
      ),
    );
  }
}
