part of 'staff_view.dart';

mixin StaffViewModel<T extends StaffView> on State<T> {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    searchController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showAddStaffDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Personel Ekle'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              context
                  .myTextFormField(
                    controller: nameController,
                    label: 'Ad Soyad',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ad Soyad giriniz';
                      }
                      return null;
                    },
                  )
                  .paddingBottom(context.smallPadding),
              context
                  .myTextFormField(
                    controller: emailController,
                    label: 'E-Mail',
                    validator: (value) {
                      RegExp regex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      );
                      if (value == null || value.isEmpty) {
                        return 'E-Mail giriniz';
                      } else if (!regex.hasMatch(value)) {
                        return 'Geçersiz E-Mail';
                      }
                      return null;
                    },
                  )
                  .paddingBottom(context.smallPadding),
              context
                  .myTextFormField(
                    controller: phoneController,
                    label: 'Telefon',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Telefon giriniz';
                      }
                      return null;
                    },
                  )
                  .paddingBottom(context.smallPadding),
              context.myTextFormField(
                controller: passwordController,
                label: 'Şifre',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre giriniz';
                  } else if (value.length < 8) {
                    return 'Şifre en az 8 karakter olmalıdır';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _clearControllers();
              Navigator.pop(context);
            },
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // TODO: Personel ekleme işlemi
                _clearControllers();
                Navigator.pop(context);
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }
}
