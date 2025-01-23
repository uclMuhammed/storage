part of '../home_view.dart';

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeViewModel viewModel;
  const _HomeAppBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: context.isSmallScreen ? true : false,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: ValueListenableBuilder(
        valueListenable: viewModel.isSearchVisible,
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (context.isSmallScreen) ...[
                value
                    ? const SizedBox.shrink()
                    : Expanded(child: context.mySubText(text: 'Dashboard')),
                value
                    ? Expanded(
                        child: context.myTextFormField(
                          controller: viewModel.searchController,
                          decoration: InputDecoration(
                            hintText: 'Ara...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              onPressed: () {
                                viewModel.isSearchVisible.value =
                                    !viewModel.isSearchVisible.value;
                                viewModel.searchController.clear();
                              },
                              icon: const Icon(Icons.close),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                context.smallBorderRadius,
                              ),
                            ),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          viewModel.isSearchVisible.value =
                              !viewModel.isSearchVisible.value;
                        },
                        icon: const Icon(Icons.search),
                      ),
              ] else ...[
                Expanded(
                  flex: 2,
                  child: context.mySubText(text: 'Dashboard'),
                ),
                Expanded(
                  flex: 3,
                  child: context.myTextFormField(
                    controller: viewModel.searchController,
                    decoration: InputDecoration(
                      hintText: 'Ara...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {
                          viewModel.searchController.clear();
                        },
                        icon: const Icon(Icons.close),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          context.smallBorderRadius,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ],
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
