part of 'warehouses_view.dart';

mixin WarehousesViewModel<T extends WarehousesView> on State<T> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final RegionsServices rServices = RegionsServices();
  final WarehousesServices wServices = WarehousesServices();
  final CitiesService cServices = CitiesService();

  @override
  void initState() {
    rServices.init();
    cServices.init();
    wServices.init();
    super.initState();
  }

  Future<void> createWarehouse() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog();
      },
    );
  }

  @override
  void dispose() {
    rServices.dispose();
    cServices.dispose();
    wServices.dispose();
    super.dispose();
  }
}
