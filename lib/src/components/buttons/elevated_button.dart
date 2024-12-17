import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      this.customChild,
      required this.buttonText,
      this.width,
      this.style,
      this.statesController,})
      : assert(customChild != null || buttonText != null),
        super(key: key);

  final void Function()? onPressed;
  final Widget? customChild;
  final String? buttonText;
  final double? width;
  final ButtonStyle? style;
  final MaterialStatesController? statesController;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      statesController: statesController,
      style: style ??
          ElevatedButton.styleFrom(
            minimumSize: width == null ? null : Size(width!, 56.h),
          ),
      child: customChild ?? Text(buttonText!),
    );
  }
}