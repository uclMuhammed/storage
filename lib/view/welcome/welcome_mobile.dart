part of 'welcome_view.dart';

class WelcomeMobile extends StatelessWidget {
  final WelcomeViewModel viewModel;
  final WelcomeBody body;
  const WelcomeMobile({super.key, required this.viewModel, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              body.buildAppTitle(context).paddingAll(context.smallPadding),
            ],
          ),
          Expanded(
            child: body.buildWelcomePage(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                body
                    .buildTitleDescription()
                    .paddingVertical(context.smallPadding),
                body.buildDescription().paddingVertical(context.smallPadding),
                body
                    .buildNextPage(context)
                    .paddingVertical(context.largePadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    viewModel.welcomeModels.length,
                    (index) => body.buildDot(index),
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
