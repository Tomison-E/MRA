import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      this.style,
      this.statesController,})
      : super(key: key);

  final void Function()? onPressed;
  final String buttonText;
  final ButtonStyle? style;
  final MaterialStatesController? statesController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      statesController: statesController,
      style: style,
      child: Text(buttonText),
    );
  }
}
