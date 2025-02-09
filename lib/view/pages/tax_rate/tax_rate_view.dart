library tax_rate;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:storage/view/pages/tax_rate/tax_rate_view_model.dart';
import 'package:widgets/widgets.dart';

part 'tax_rate_body.dart';
part 'dialog/tax_rate_update.dart';
part 'dialog/tax_rate_create.dart';
part 'dialog/tax_rate_delete.dart';

class TaxRateView extends BaseView {
  final TaxRateBody body;
  TaxRateView({super.key}) : body = TaxRateBody();

  @override
  Widget buildDesktopView(BuildContext context) {
    return body.build(context);
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return body.build(context);
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return body.build(context);
  }
}
