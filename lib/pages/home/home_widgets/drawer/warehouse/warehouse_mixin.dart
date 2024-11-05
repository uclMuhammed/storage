part of 'warehouse.dart';

mixin WareHouseMixin on State<WareHouse> {
  final List<Warehouses> depolar = [];

  TextEditingController _wNameController = TextEditingController();
  TextEditingController _wAddressController = TextEditingController();

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
                keyboardType: TextInputType.name,
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
                addDepo(_wNameController.text, _wAddressController.text);
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

  void addDepo(String wName, String wAddress) {
    depolar.add(Warehouses(
        warehouse: 1,
        description: wName,
        region_id: 1,
        company_id: 1,
        address: wAddress,
        isActive: true,
        isDelete: false,
        createDat: DateTime(2001, 9, 27),
        updateDat: DateTime(2001, 9, 27),
        deleteDat: DateTime(2001, 9, 27),
        createBy: 'maho',
        updatedBy: 'maho',
        deletedBy: 'maho',
        id: 1));
    setState(() {});
  }
}
