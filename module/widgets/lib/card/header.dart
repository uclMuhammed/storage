import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final Key parentKey;
  const HeaderCard({
    super.key,
    required this.parentKey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 60) {
        return const _SmallHeader();
      }
      return const _LargeHeader();
    });
  }
}

class _SmallHeader extends StatelessWidget {
  const _SmallHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.open_in_full),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}

class _LargeHeader extends StatelessWidget {
  const _LargeHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          spacing: 8,
          children: [
            CircleAvatar(
              radius: 30,
            ),
            Text('Name Surname'),
            Text('Owner'),
            Text('email@example.com'),
          ],
        ),
      );
    });
  }
}
