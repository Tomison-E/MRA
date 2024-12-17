import 'package:mra/src/components/margin.dart';
import 'package:flutter/material.dart';
import 'package:open_app_settings/open_app_settings.dart';

class PermissionDialog extends StatelessWidget {
  final String? permission;
  const PermissionDialog({super.key, this.permission});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Permission Required',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const ColSpacing(20),
                  Text(
                    'Your action cannot be completed unless you allow access to $permission. Proceed?',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                OpenAppSettings.openAppSettings();
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }

  static void display(BuildContext context, String permission) => showDialog(
      context: context,
      builder: (ctx) {
        return PermissionDialog(permission: permission);
      });
}
