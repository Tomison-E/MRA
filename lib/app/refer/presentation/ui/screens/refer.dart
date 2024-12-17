import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class ReferScreen extends StatelessWidget {
  const ReferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text(
        'Feedback',
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: SvgPicture.asset(kBackIconSvg),
      ),
    ),);
  }
}
