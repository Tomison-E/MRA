import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/home_settings_providers.dart';
import 'package:mra/app/home_settings/presentation/ui/widgets/household_member_card.dart';
import 'package:mra/app/home_settings/presentation/ui/widgets/main_host_card.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class HomeSettingsScreen extends StatelessWidget {
  const HomeSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Settings',
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(kBackIconSvg),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ColSpacing(40.h),
            //MAIN HOST
            const MainHostCard(),
            ColSpacing(32.h),
            Consumer(builder: (context, ref, _) {
              ref.listen(houseHoldStateProvider, (previous, next) {
                next.maybeWhen(orElse: (){},error: (error,_){
                  Toast.exception(error, context);
                });
              });
              final state = ref.watch(houseHoldStateProvider);
              return state.when(
                data: (personnel) => Column(
                  children: [
                    HouseHoldCard(
                      title: 'Household members',
                      type: PersonnelType.member,
                      personnel: personnel,
                    ),
                    ColSpacing(32.h),
                    HouseHoldCard(
                      title: 'Household staff',
                      type: PersonnelType.staff,
                      personnel: personnel,
                    ),
                  ],
                ),
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const LoadingState(),
              );
            }),
            // HOUSEHOLD
          ],
        ),
      ),
    );
  }
}
