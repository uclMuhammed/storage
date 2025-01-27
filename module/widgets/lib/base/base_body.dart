import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

abstract class BaseBody {
  // Build the header section of the body
  Widget buildHeader(BuildContext context);

  // Build the body section of the body
  Widget buildBody(BuildContext context);

  // Build the footer section of the body
  Widget buildFooter(BuildContext context);
}
