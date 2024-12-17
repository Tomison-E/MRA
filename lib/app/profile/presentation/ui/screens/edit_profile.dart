import 'package:mra/app/profile/presentation/ui/screens/personal.dart';
import 'package:mra/app/profile/presentation/ui/screens/security.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            elevation: .5,
            shadowColor: kHelperTextColor,
            title: const Text(
              'Profile',
            ),
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: SvgPicture.asset(kBackIconSvg),
            ),
            bottom: TabBar(
              indicatorColor: kTextTitleColor,
              indicatorWeight: 1.5,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              tabs: const [
                Tab(
                  text: 'Personal',
                ),
                Tab(
                  text: 'Security',
                )
              ],
            )),
        body: const TabBarView(
          children: [
            PersonalTabView(),
            SecurityTabView(),
          ],
        ),
      ),
    );
  }
}
