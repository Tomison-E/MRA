import 'package:mra/app/alert/presentation/ui/widgets/alert_history.dart';
import 'package:mra/app/alert/presentation/ui/widgets/alert_report.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AlertScreen extends ConsumerWidget {
  const AlertScreen({Key? key}) : super(key: key);

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
            'Alert',
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
            tabs: isResident
                ? const [
                    Tab(
                      text: 'Active',
                    ),
                    Tab(
                      text: 'History',
                    )
                  ]
                : const [
                    Tab(
                      text: 'Unresponded',
                    ),
                    Tab(
                      text: 'Active',
                    )
                  ],
          ),
        ),
        body: isResident
            ? const TabBarView(children: [
                AlertReport(),
                AlertHistory(type: AlertHistoryType.all)
              ])
            : const TabBarView(children: [
                AlertHistory(type: AlertHistoryType.unResponded),
                AlertHistory(type: AlertHistoryType.active)
              ]),
      ),
    );
  }
}
