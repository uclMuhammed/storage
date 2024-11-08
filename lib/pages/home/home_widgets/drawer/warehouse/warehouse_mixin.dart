part of 'warehouse.dart';

mixin WareHouseMixin on State<WareHouse> {
  final List<Warehouses> depolar = [];
  final TextEditingController _wNameController = TextEditingController();
  final TextEditingController _wAddressController = TextEditingController();

  void addButton() {
    int wAddress = int.tryParse(_wAddressController.text) ?? 0;
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
                addDepo(_wNameController.text, wAddress);
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

  void tokenButton() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    print(token);
  }

  void addDepo(String wName, int wAddress) {
    //Warehousesservices().addWarehouses(wAddress, wName);
  }
}
