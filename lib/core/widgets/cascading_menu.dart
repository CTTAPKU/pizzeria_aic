import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CascadingMenu extends StatelessWidget {
  const CascadingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          onPressed: () async {
            final url = Uri.https('github.com', '/CTTAPKU/pizzeria_app');
            await launchUrl(url);
          },
          child: const Text("Інформація"),
        ),
        MenuItemButton(
          onPressed: () async {
            final url = Uri.https('t.me', '/akkurokawa');
            await launchUrl(url);
          },
          child: const Text("Допомога"),
        )
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }
}
