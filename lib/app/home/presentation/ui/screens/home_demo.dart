import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/home/presentation/methods/home_state.dart';
import 'package:mra/app/home/presentation/ui/widgets/features.dart';
import 'package:mra/app/home/presentation/ui/widgets/show_case_info_card.dart';
import 'package:mra/app/home/presentation/ui/widgets/upcoming_item_tile.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

// I am having issues aligning the showCase widget to the center of the screen

class HomeDemoScreen extends StatefulWidget {
  const HomeDemoScreen({super.key});

  @override
  State<HomeDemoScreen> createState() => _HomeDemoScreenState();
}

class _HomeDemoScreenState extends State<HomeDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      disableBarrierInteraction: true,
      builder: Builder(builder: (context) {
        return const HomeDemoShowCase();
      }),
    );
  }
}

class HomeDemoShowCase extends ConsumerStatefulWidget {
  const HomeDemoShowCase({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeDemoShowCase> createState() => _HomeDemoShowCaseState();
}

class _HomeDemoShowCaseState extends ConsumerState<HomeDemoShowCase>
    with HomeState {
  GlobalKey accessControlKey = GlobalKey();
  GlobalKey servicesKey = GlobalKey();
  GlobalKey noticeBoardKey = GlobalKey();
  GlobalKey menuKey = GlobalKey();
  late final user = ref.read(userStateProvider)!;
  late final appFeatures = getAppFeatures(user.role);
  late final upcomingItems = getUpcomingItems(user.role);
  late final bottomNavBar = getAppBottomNavBar(user.role);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context).startShowCase(
          [accessControlKey, servicesKey, noticeBoardKey, menuKey]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    List<GlobalKey> featureKeys = [
      accessControlKey,
      servicesKey,
      noticeBoardKey
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                ColSpacing(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Showcase.withWidget(
                      key: menuKey,
                      disableDefaultTargetGestures: true,
                      disableMovingAnimation: true,
                      tooltipPosition: TooltipPosition.bottom,
                      overlayColor: kD9D9D9,
                      overlayOpacity: 0.8,
                      height: 164.h,
                      width: 321.w,
                      container: ShowCaseInfoCard(
                        index: 3,
                        title: 'Menu',
                        showCaseText: 'Click here to browse other features',
                        onCompleted: () {
                          ShowCaseWidget.of(context).dismiss();
                          context.goNamed(kHomeRoute);
                        },
                      ),
                      child: SvgPicture.asset(
                        kProfileIconSvg,
                      ),
                    ),
                    if (user.isResident)
                      SvgPicture.asset(
                        kNotificationIconSvg,
                      ),
                  ],
                ),
                ColSpacing(40.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey Efosa.',
                        style: theme.headlineSmall,
                      ),
                      ColSpacing(
                        8.h,
                      ),
                      Text(
                        'House 5 southern view estate,',
                        style:
                            theme.bodyLarge?.copyWith(color: kHelperTextColor),
                      ),
                    ],
                  ),
                ),
                ColSpacing(
                  32.h,
                ),

                //APP FEATURES
                ...List.generate(appFeatures.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                    ),
                    child: Showcase.withWidget(
                      disableMovingAnimation: true,
                      tooltipPosition: TooltipPosition.bottom,
                      overlayColor: kD9D9D9,
                      overlayOpacity: 0.8,
                      key: featureKeys[index],
                      height: 164.h,
                      width: 321.w,
                      container: ShowCaseInfoCard(
                        index: index,
                        title: appFeatures[index].title,
                        showCaseText: appFeatures[index].showCaseText,
                        onSkip: () {
                          ShowCaseWidget.of(context).dismiss();
                          context.goNamed(kHomeRoute);
                        },
                        onNext: () => ShowCaseWidget.of(context).next(),
                      ),
                      child: AppFeatureCard(
                        feature: appFeatures[index],
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Column(
                    children: [
                      //if not upcoming is not empty, then show text and upcoming events and payments
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upcoming',
                          style: theme.labelLarge?.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      ColSpacing(
                        24.h,
                      ),
                      ...List.generate(
                        upcomingItems.length,
                        (index) => UpcomingItemTile(item: upcomingItems[index]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBar,
        iconSize: 48.h,
      ),
    );
  }
}
