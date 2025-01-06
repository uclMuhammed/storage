part of 'edit_profile_view.dart';

mixin EditProfileViewModel on State<EditProfileView> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isTwoFactorEnabled = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  void dispose() {
    companyNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    // API'den kullanıcı verilerini yükle
  }

  Future<void> handleProfilePhotoUpdate() async {
    // Profil fotoğrafı güncelleme işlemi
  }

  Future<void> handlePasswordChange() async {
    if (newPasswordController.text == confirmPasswordController.text) {
      // TODO: Şifre değiştirme API çağrısı
      // currentPasswordController.text -> eski şifre
      // newPasswordController.text -> yeni şifre
    }
  }
}
