part of 'category_view.dart';

class CategoryBody {
  final CategoryViewModel viewModel;
  final ScrollController scrollController = ScrollController();

  CategoryBody() : viewModel = CategoryViewModel()..init() {
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {}
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: buildHeader(context),
        ),
        Expanded(child: buildFooter(context)),
        Expanded(
          child: Row(
            children: [
              context.mySubText(text: 'Alt Kategoriler'),
            ],
          ).paddingHorizontal(context.smallPadding),
        ),
        Expanded(
          flex: 2,
          child: buildSubHeader(context),
        ),
        Expanded(child: buildSubFooter(context)),
      ],
    );
  }

  Widget buildHeader(BuildContext context) {
    return FutureBuilder<void>(
      future: viewModel.initializeServices(),
      builder: (context, initSnapshot) {
        if (initSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (initSnapshot.hasError) {
          return Center(
              child: Text('Servis başlatma hatası: ${initSnapshot.error}'));
        }

        return ValueListenableBuilder<List<Categories>>(
          valueListenable: viewModel.categories,
          builder: (context, categories, _) {
            if (categories.isEmpty) {
              return const Center(child: Text('Kategori bulunamadı'));
            }

            return ValueListenableBuilder<bool>(
              valueListenable: viewModel.loadingNotifier,
              builder: (context, isLoading, _) {
                return RefreshIndicator(
                  onRefresh: viewModel.refresh,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected =
                            category.id == viewModel.selectedCategory.value?.id;
                        return Container(
                          width: 300,
                          margin: const EdgeInsets.only(right: 16),
                          child: Card(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                            child: InkWell(
                              onTap: () {
                                viewModel.selectedCategory.value = category;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            category.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '#${category.id}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(Icons.category, size: 24),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildSubHeader(BuildContext context) {
    return ValueListenableBuilder<Categories?>(
      valueListenable: viewModel.selectedCategory,
      builder: (context, selectedCategory, _) {
        if (selectedCategory == null) {
          return const Center(child: Text('Lütfen bir kategori seçin'));
        }

        return ValueListenableBuilder<List<CategoriesSub>>(
          valueListenable: viewModel.subCategories,
          builder: (context, subCategories, _) {
            return ValueListenableBuilder<bool>(
              valueListenable: viewModel.loadingNotifier,
              builder: (context, isLoading, _) {
                if (isLoading && subCategories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ValueListenableBuilder<String?>(
                  valueListenable: viewModel.error,
                  builder: (context, error, _) {
                    if (error != null && subCategories.isEmpty) {
                      return Center(child: Text(error));
                    }

                    return RefreshIndicator(
                      onRefresh: viewModel.refresh,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          itemCount: subCategories.length,
                          itemBuilder: (context, index) {
                            final subCategory = subCategories[index];
                            return ValueListenableBuilder<CategoriesSub?>(
                              valueListenable: viewModel.selectedSubCategory,
                              builder: (context, selectedSubCategory, _) {
                                final isSelected =
                                    selectedSubCategory?.id == subCategory.id;
                                return Container(
                                  width: 300,
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Card(
                                    color: isSelected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .surfaceContainerHighest,
                                    child: InkWell(
                                      onTap: () {
                                        viewModel.selectedSubCategory.value =
                                            subCategory;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    subCategory.description,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '#${subCategory.id}',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Icon(Icons.category,
                                                    size: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildFooter(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (context, isLoading, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              tooltip: 'Kategori Sil',
              heroTag: 'delete',
              onPressed: isLoading || viewModel.selectedCategory.value == null
                  ? null
                  : () async {
                      await viewModel.deleteCategory(
                        viewModel.selectedCategory.value!.id!,
                      );
                    },
              child: const Icon(Icons.delete),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Kategori Düzenle',
              heroTag: 'edit',
              onPressed: isLoading || viewModel.selectedCategory.value == null
                  ? null
                  : () {
                      CategoryEdit(
                        context: context,
                        viewModel: viewModel,
                        category: viewModel.selectedCategory.value!,
                      ).show(context);
                    },
              child: const Icon(Icons.edit),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Kategori Ekle',
              heroTag: 'add',
              onPressed: isLoading
                  ? null
                  : () {
                      CategoryCreate(
                        context: context,
                        viewModel: viewModel,
                      ).show(context);
                    },
              child: const Icon(Icons.add),
            ),
          ],
        ).paddingHorizontal(context.smallPadding);
      },
    );
  }

  Widget buildSubFooter(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (context, isLoading, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              tooltip: 'Alt Kategori Sil',
              heroTag: 'delete_sub',
              onPressed: isLoading ||
                      viewModel.selectedSubCategory.value == null ||
                      viewModel.selectedCategory.value == null
                  ? null
                  : () async {
                      await viewModel.deleteSubCategory();
                    },
              child: const Icon(Icons.delete),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Alt Kategori Düzenle',
              heroTag: 'edit_sub',
              onPressed: isLoading ||
                      viewModel.selectedSubCategory.value == null ||
                      viewModel.selectedCategory.value == null
                  ? null
                  : () {
                      CategorySubEdit(
                        context: context,
                        viewModel: viewModel,
                        subCategory: viewModel.selectedSubCategory.value!,
                      ).show(context);
                    },
              child: const Icon(Icons.edit),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Alt Kategori Ekle',
              heroTag: 'add_sub',
              onPressed: isLoading || viewModel.selectedCategory.value == null
                  ? null
                  : () {
                      CategorySubCreate(
                        context: context,
                        viewModel: viewModel,
                      ).show(context);
                    },
              child: const Icon(Icons.add),
            ),
          ],
        ).paddingHorizontal(context.smallPadding);
      },
    );
  }
}
