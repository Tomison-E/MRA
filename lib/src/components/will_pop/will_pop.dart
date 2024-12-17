import 'package:mra/src/components/loader/loader.dart';
import 'package:flutter/material.dart';

class WillPop extends StatelessWidget {
  final Widget child;
  final bool canPop;

  const WillPop({
    Key? key,
    required this.child,
    this.canPop = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Loader.isLoading ? false : canPop,
      child: child,
    );
  }
}
