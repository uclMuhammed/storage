import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

moreWert(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      // Seçilen değere göre işlem yapabilirsiniz
      if (value == 'Kategoriler') {
        if (kDebugMode) {
          print('Kategoriler selected');
        }
      } else if (value == 'Profil') {
        if (kDebugMode) {
          print('Profile selected');
        }
      }
    },
    itemBuilder: (BuildContext context) {
      return {
        'Kategoriler',
        'Profil',
      }.map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice),
        );
      }).toList();
    },
  );
}
