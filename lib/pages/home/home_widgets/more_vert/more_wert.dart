import 'package:flutter/material.dart';

moreWert(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      // Seçilen değere göre işlem yapabilirsiniz
      if (value == 'Kategoriler') {
        print('Kategoriler selected');
      } else if (value == 'Profil') {
        print('Profile selected');
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
