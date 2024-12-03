part of 'warehouse.dart';

mixin WareHouseMixin on State<WareHouse> {
  final AuthoritiesService _author = AuthoritiesService();
  final TextEditingController _wNameController = TextEditingController();
  final TextEditingController _wAddressController = TextEditingController();

  void addButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Yeni Depo Ekle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                keyboardType: TextInputType.name,
                controller: _wNameController,
                text: "Depo Adı",
                obscureText: false,
              ),
              const SizedBox(height: 8.0),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: _wAddressController,
                text: "Depo Yeri",
                obscureText: false,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _wNameController.clear();
                _wAddressController.clear();
              },
              child: const Text("Vazgeç"),
            ),
            ElevatedButton(
              onPressed: () {
                authorGetAll();
                Navigator.of(context).pop();
                _wNameController.clear();
                _wAddressController.clear();
              },
              child: const Text("Ekle"),
            )
          ],
        );
      },
    );
  }

  Future<void> authorGetAll() async {
    try {
      await _author.init();
      //
      final response = await _author.getAll();
      //
      if (response.isNotEmpty) {
        if (kDebugMode) print('Authorities: $response');
      } else {
        if (kDebugMode) print('Authorities Not Found');
      }
      //
      response.map((e) {
        if (kDebugMode) print('Authorities: $e');
      }).toList();
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
}
