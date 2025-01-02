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
        Row(
          children: [context.mySubheadingText(text: 'Edit Profile')],
        ),
        Column(
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
        ).paddingAll(context.padding),
        Row(
          children: [context.mySubheadingText(text: 'Chanege Password')],
        ),
        Column(
          children: [
            context.myTextFormField(
              hint: 'Email giriniz',
              label: 'Email',
              title: 'Send to Email',
              controller: emailController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                context.myButton(buttonText: 'Send', onPressed: () {}),
              ],
            ),
          ],
        ).paddingAll(context.padding),
      ],
    );
  }
  //--------------------------------------------------------------

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
