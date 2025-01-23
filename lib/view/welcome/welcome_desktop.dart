part of 'welcome_view.dart';

class WelcomeDesktop extends StatelessWidget {
  final WelcomeViewModel viewModel;
  final WelcomeBody body;
  const WelcomeDesktop({
    super.key,
    required this.viewModel,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.white),
              ),
            ),
            child: Column(
              children: [
                body.buildAppTitle(context),
                context.myLine().paddingVertical(context.smallPadding),
                Expanded(
                  child: Center(
                    child: body.buildTitleDescription(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: body.buildDescription(),
                ),
              ],
            ).paddingAll(context.smallPadding),
          ),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                Expanded(child: body.buildWelcomePage()),
                body.buildNextPage(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    viewModel.welcomeModels.length,
                    (index) => body.buildDot(index),
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
