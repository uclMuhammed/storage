import 'package:flutter/material.dart';
import 'package:widgets/index.dart';
part 'edit_profile_view_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    with EditProfileViewModel {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  //--------------------------------------------------------------
  Column _editProfile(BuildContext context) {
    return Column(
      children: [
        _buildProfileHeader(context),
        _buildCompanyNameSection(context),
        _buildEmailSection(context),
        _buildPhoneSection(context),
        _buildPasswordSection(context),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.mySubheadingText(text: 'Profil Düzenle'),
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              'https://api.dicebear.com/7.x/avataaars/svg?seed=John'),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () => handleProfilePhotoUpdate(),
                ),
              ),
            ],
          ),
        ),
      ],
    ).paddingAll(context.padding);
  }

  Widget _buildCompanyNameSection(BuildContext context) {
    return Column(
      children: [
        context.myTextFormField(
          hint: 'Company Name giriniz',
          label: 'Company Name',
          title: 'Company Name',
          controller: companyNameController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            context.myButton(buttonText: 'Save', onPressed: () {}),
          ],
        ),
      ],
    ).paddingAll(context.padding);
  }

  Widget _buildEmailSection(BuildContext context) {
    return Column(
      children: [
        context.myTextFormField(
          hint: 'E-Mail giriniz',
          label: 'E-Mail',
          title: 'E-Mail',
          controller: emailController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            context.myButton(buttonText: 'Save', onPressed: () {}),
          ],
        ),
      ],
    ).paddingAll(context.padding);
  }

  Widget _buildPhoneSection(BuildContext context) {
    return Column(
      children: [
        context.myTextFormField(
          hint: 'Phone Number giriniz',
          label: 'Phone Number',
          title: 'Phone Number',
          controller: phoneNumberController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            context.myButton(buttonText: 'Save', onPressed: () {}),
          ],
        ),
      ],
    ).paddingAll(context.padding);
  }

  Widget _buildPasswordSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.mySubheadingText(text: 'Şifre Değiştirme'),
        const SizedBox(height: 16),
        context.myTextFormField(
          controller: currentPasswordController,
          label: 'Mevcut Şifre',
          obscureText: true,
        ),
        const SizedBox(height: 16),
        context.myTextFormField(
          controller: newPasswordController,
          label: 'Yeni Şifre',
          obscureText: true,
        ),
        const SizedBox(height: 16),
        context.myTextFormField(
          controller: confirmPasswordController,
          label: 'Yeni Şifre (Tekrar)',
          obscureText: true,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            context.myButton(
              buttonText: 'Şifre Değiştir',
              onPressed: handlePasswordChange,
            ),
          ],
        ),
      ],
    ).paddingAll(context.padding);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildDesktopLayout(context);
  }

  Widget _buildTabletLayout(BuildContext context) {
    return _buildDesktopLayout(context);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _editProfile(context).paddingAll(context.padding),
      ),
    );
  }
}
