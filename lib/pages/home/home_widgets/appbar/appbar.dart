import 'package:flutter/material.dart';
import 'package:storage/authority_manager/authority_type_implementations.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';
import 'package:storage/pages/home/home_widgets/more_vert/more_wert.dart';

AppBar myAppBar(
  bool changeAppbar,
  AuthManager authManager,
  BuildContext context,
  Function() onPressed,
) {
  return AppBar(
    title: const Text(
      'WareHouse',
    ),
    actions: [
      IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.search),
      ),
      if (authManager.userAuthority != null) AuthorityBadge(authority: authManager.userAuthority!),
      moreWert(context),
    ],
  );
}
