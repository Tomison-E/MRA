import 'package:mra/src/components//margin.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  final String? message;

  const NotFoundPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SvgPicture.asset(kLogoSvg, alignment: Alignment.center),
            const ColSpacing(30),
            // const Text("Oops! Page not found! "),
            const ColSpacing(20),
            Text(
                message ??
                    "We are very sorry for inconvenience. It looks like you’re trying to access page that has been deleted or never existed. ",
                textAlign: TextAlign.center,),
            const ColSpacing(30),
            ElevatedButton(
              child: const Text("Back to Home"),
              onPressed: () => context.goNamed(kOnBoardingRoute),
            ),
          ],
        ),
      ),
    );
  }
}
