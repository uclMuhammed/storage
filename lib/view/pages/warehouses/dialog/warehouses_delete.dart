part of warehouses;

class WarehousesDelete {
  final Warehouses warehouse;
  final BuildContext context;

  WarehousesDelete({
    required this.warehouse,
    required this.context,
  });

  Future<bool?> show() async {
    final _authClient = ServiceAuthClient();
    final token = await _authClient.getAuthToken();

    final warehouseService = ServiceApiClient<Warehouses>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/warehouses',
      fromJson: (json) => Warehouses.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Depo Sil'),
          content: Text(
              '${warehouse.description} deposunu silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await warehouseService.deleteById(warehouse.id!);
                  Navigator.pop(context, true);
                } catch (e) {
                  Navigator.pop(context, false);
                }
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
