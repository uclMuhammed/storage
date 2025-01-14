import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard(
      {super.key,
      required this.height,
      required this.width,
      required this.url});

  final double height;
  final double width;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      // -----------------
      child: Column(
        children: [
          // CircleAvatar(
          //   backgroundImage: NetworkImage(url),
          //   radius: 30,
          // ),
          const Row(
            children: [
              Text('Name Surname'),
              Text('Owner'),
            ],
          ),
          const Text('email@example.com'),
        ],
      ),
    );
  }
}
