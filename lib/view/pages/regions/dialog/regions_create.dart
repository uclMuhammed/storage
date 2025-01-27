part of regions;

class RegionsCreate {
  final BuildContext context;
  final RegionsViewModel viewModel;

  RegionsCreate({required this.context, required this.viewModel});

  Future<bool?> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();

    final authClient = ServiceAuthClient();
    final token = await authClient.getAuthToken();

    final regionService = ServiceApiClient<Regions>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/regions',
      fromJson: (json) => Regions.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Bölge'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context
                      .myTextFormField(
                        labelText: 'Bölge Adı',
                        controller: nameController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Bölge adı gerekli' : null,
                      )
                      .paddingVertical(context.smallPadding),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState?.validate() == true) {
                  final newRegion = Regions.insert(nameController.text);
                  await regionService.create(newRegion);
                  viewModel.refreshTrigger.value =
                      !viewModel.refreshTrigger.value;
                  Navigator.pop(context, newRegion);
                }
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }
}
