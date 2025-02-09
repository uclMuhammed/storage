part of 'porject_view.dart';

class ProjectBody {
  final ProjectViewModel viewModel;
  ProjectBody() : viewModel = ProjectViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.projects,
      builder: (context, value, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: viewModel.loadingNotifier,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (value.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Proje oluşturmak için tıklayınız',
                  child: context.myCard(
                    onTap: () {
                      ProjectCreate(
                        context: context,
                        viewModel: viewModel,
                      ).show();
                    },
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    width: 100,
                    height: 100,
                    child: const Icon(Icons.add),
                  ),
                ),
              );
            }
            if (viewModel.error.value != null) {
              return Center(child: Text(viewModel.error.value!));
            }

            return Column(children: [
              Expanded(
                flex: 1,
                child: buildHeader(context),
              ),
              Expanded(
                flex: 3,
                child: buildBody(context),
              ),
            ]);
          },
        );
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return ValueListenableBuilder<List<ProjectCode>>(
      valueListenable: viewModel.projects,
      builder: (context, projects, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(
            horizontal: context.smallPadding,
            vertical: context.smallPadding,
          ),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: projects
              .map(
                (p) => context.myCard(
                  onTap: () {
                    viewModel.selectedProject.value = p;
                  },
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: context.mySubText(text: p.description),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            context.myText(
                              text: '#${p.id}',
                              style: TextStyle(
                                fontSize: context.bodySize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.inbox,
                              size: context.iconSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return ValueListenableBuilder<ProjectCode?>(
      valueListenable: viewModel.selectedProject,
      builder: (context, selectedProject, _) {
        if (selectedProject == null) {
          return const Center(child: Text('Lütfen bir proje seçiniz'));
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.borderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.smallPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(context.borderRadius),
                    ),
                    child: context.mySubheadingText(
                      text: '#${selectedProject.id}',
                    ),
                  ),
                  SizedBox(width: context.smallPadding),
                  context.mySubheadingText(text: 'Proje Detayları'),
                  const Spacer(),
                  buildFooter(context),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'İsim:',
                        value: selectedProject.description,
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'Başlangıç Tarihi:',
                        value: selectedProject.startDate
                            .toString()
                            .replaceRange(10, null, ''),
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'Bitiş Tarihi:',
                        value: selectedProject.endDate
                            .toString()
                            .replaceRange(10, null, ''),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingAll(context.smallPadding),
        ).paddingAll(context.smallPadding);
      },
    );
  }

  Widget buildFooter(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Proje Sil',
            heroTag: 'delete',
            onPressed: () {
              ProjectDelete(
                context: context,
                viewModel: viewModel,
                project: viewModel.selectedProject.value ?? ProjectCode.empty(),
              ).show();
            },
            child: const Icon(Icons.delete),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            tooltip: 'Proje Düzenle',
            heroTag: 'edit',
            onPressed: () {
              ProjectUpdate(
                context: context,
                viewModel: viewModel,
                project: viewModel.selectedProject.value ?? ProjectCode.empty(),
              ).show();
            },
            child: const Icon(Icons.edit),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            tooltip: 'Proje Ekle',
            heroTag: 'add',
            onPressed: () {
              ProjectCreate(
                context: context,
                viewModel: viewModel,
              ).show();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
