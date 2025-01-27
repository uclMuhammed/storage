part of regions;

class RegionsEdit {
  final Regions region;
  final BuildContext context;
  final RegionsViewModel viewModel;

  RegionsEdit({
    required this.region,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: region.description);

    final authClient = ServiceAuthClient();
    final token = await authClient.getAuthToken();

    final regionService = ServiceApiClient<Regions>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/regions',
      fromJson: (json) => Regions.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bölge Düzenle'),
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
                  final updatedRegion = Regions.insert(nameController.text);
                  final response = await regionService.updateById(
                    region.id!,
                    updatedRegion,
                  );
                  viewModel.refreshTrigger.value =
                      !viewModel.refreshTrigger.value;
                  Navigator.pop(context, updatedRegion);
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
