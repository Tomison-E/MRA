import 'package:mra/src/components/margin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  final String info;
  final String svgAsset;
  final bool isComponentWidget;
  const EmptyState(this.svgAsset, {super.key, required this.info, this.isComponentWidget = false});

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(svgAsset,height: isComponentWidget? 150 : null),
          const ColSpacing(10),
          Text(info,textAlign: TextAlign.center,)
        ],
    );
  }
}
