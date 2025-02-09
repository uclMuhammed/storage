library project;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

import 'project_view_model.dart';

part 'project_body.dart';
part 'dialog/project_create.dart';
part 'dialog/project_delete.dart';
part 'dialog/project_update.dart';

class ProjectView extends BaseView {
  final ProjectBody body;
  ProjectView({super.key}) : body = ProjectBody();

  @override
  Widget buildDesktopView(BuildContext context) => body.build(context);

  @override
  Widget buildTabletView(BuildContext context) => body.build(context);

  @override
  Widget buildMobileView(BuildContext context) => body.build(context);
}
