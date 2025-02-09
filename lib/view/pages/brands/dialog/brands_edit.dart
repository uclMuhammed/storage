part of '../brands_view.dart';

class BrandsEdit extends StatefulWidget {
  final BuildContext context;
  final BrandsViewModel viewModel;
  final Brands brand;

  const BrandsEdit({
    required this.context,
    required this.viewModel,
    required this.brand,
    super.key,
  });

  Future<void> show() async {
    await showDialog(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  State<BrandsEdit> createState() => _BrandsEditState();
}

class _BrandsEditState extends State<BrandsEdit> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.brand.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Marka Düzenle'),
      content: Form(
        key: _formKey,
        child: context.myTextFormField(
          controller: _nameController,
          labelText: 'Marka Adı',
          prefixIcon: Icons.branding_watermark,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Lütfen marka adı giriniz';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await widget.viewModel.updateBrand(_nameController.text);
              // ignore: use_build_context_synchronously
              if (mounted) Navigator.pop(context);
            }
          },
          child: const Text('Güncelle'),
        ),
      ],
    );
  }
}
