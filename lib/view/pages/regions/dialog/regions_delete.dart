part of regions;

class RegionsDelete {
  final Regions region;
  final BuildContext context;
  final RegionsViewModel viewModel;

  RegionsDelete({
    required this.context,
    required this.viewModel,
    required this.region,
  });

  Future<bool?> show() async {
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
          title: const Text('Bölge Sil'),
          content: Text(
              '${region.description} bölgesini silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await regionService.deleteById(region.id!);
                  viewModel.refreshTrigger.value =
                      !viewModel.refreshTrigger.value;
                  Navigator.pop(context, true);
                } catch (e) {
                  Navigator.pop(context, false);
                }
              },
              child: const Text(
                'Sil',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
