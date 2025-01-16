import 'package:flutter/material.dart';
import 'package:widgets/const/padding.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 200) {
        return const _LargeHeader();
      }
      return const _SmallHeader();
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
    return const FittedBox(
      child: Padding(
        padding: normalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            CircleAvatar(
              radius: 36,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name Surname'),
                Text('Owner'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
