import 'package:mra/app/access_control/presentation/ui/screens/grant_access.dart';
import 'package:mra/app/access_control/presentation/ui/screens/guest_history_view.dart';
import 'package:mra/app/access_control/presentation/ui/screens/guest_verification.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AccessControlScreen extends ConsumerWidget {
  const AccessControlScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isResident = ref.watch(userStateProvider)!.isResident;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: .5,
          shadowColor: kHelperTextColor,
          title: const Text(
            'Access Control',
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
                text: 'Grant Access',
              ),
              Tab(
                text: 'Guest History',
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          isResident ? const GrantAccess() : const GuestVerification(),
          const GuestHistoryView()
        ]),
      ),
    );
  }
}
