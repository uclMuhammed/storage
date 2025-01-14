part of '../welcome_view.dart';

class _WelcomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _WelcomeAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text(
        'Storage App',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
