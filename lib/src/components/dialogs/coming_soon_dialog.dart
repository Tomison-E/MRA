import 'package:flutter/material.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "This feature will be made available in a later release",
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  static display(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const SimpleDialog(
          title: Text(
            "Coming Soon",
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.all(30),
          titlePadding: EdgeInsets.only(left: 30, top: 30, right: 30),
          children: [ComingSoonDialog()],
        );
      },
    );
  }
}
