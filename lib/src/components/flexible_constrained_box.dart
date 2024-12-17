import 'package:flutter/material.dart';

class FlexibleConstrainedBox extends StatelessWidget {
  final Widget child;
  final double minHeight;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const FlexibleConstrainedBox(
      {super.key,
      required this.child,
      this.minHeight = 500,
      this.padding,
      this.physics});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        padding: padding,
        physics: physics,
        child: ConstrainedBox(
          constraints: BoxConstraints(
                  minHeight: minHeight,
                  maxHeight: viewportConstraints.maxHeight)
              .flexible,
          child: child,
        ),
      );
    });
  }
}

extension Scroll on BoxConstraints {
  BoxConstraints get flexible => BoxConstraints(
      minHeight: minHeight,
      maxHeight: maxHeight > minHeight ? maxHeight : minHeight);
}
