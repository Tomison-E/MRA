import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/home/presentation/methods/home_state.dart';
import 'package:mra/app/home/presentation/ui/drawer/drawer.dart';
import 'package:mra/app/home/presentation/ui/modals/on_boarding_checklist_modal.dart';
import 'package:mra/app/home/presentation/ui/widgets/features.dart';
import 'package:mra/app/home/presentation/ui/widgets/todo.dart';
import 'package:mra/app/payments/presentation/logic/payments_state.dart';
import 'package:mra/app/payments/presentation/ui/widgets/upcoming_payment_tile.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with HomeState {
  final GlobalKey<ScaffoldState> _homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final user = ref.watch(userStateProvider);
    final isResident = user?.isResident ?? false;
    final house = isResident ? user?.addresses.firstOrNull : null;
    final estate = user?.estate;
    /* bool todoComplete = user?.todoComplete ?? false;
    int checklistPercentage = !todoComplete &&
            (user?.acceptTerms ?? false || user?.profileImageUrl != null)
        ? 70
        : 30;*/
    final appFeatures = getAppFeatures(user?.role ?? UserType.resident);
    final paymentState = ref.watch(paymentStateProvider);
    return Scaffold(
      key: _homeScaffoldKey,
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              ColSpacing(
                24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      isResident
                          ? _homeScaffoldKey.currentState?.openDrawer()
                          : context.pushNamed(kProfileRoute);
                    },
                    child: SvgPicture.asset(kMenuSvg,
                        colorFilter: const ColorFilter.mode(
                            kPrimaryColor, BlendMode.srcIn)),
                  ),
                  InkWell(
                    onTap: () => context.pushNamed(kNotificationRoute),
                    child: SvgPicture.asset(kNotificationIconSvg,
                        colorFilter: const ColorFilter.mode(
                            kPrimaryColor, BlendMode.srcIn)),
                  ),
                ],
              ),
              ColSpacing(40.h),
              /*     if (!todoComplete && isResident) ...[
                InkWell(
                  onTap: () =>
                      OnBoardingChecklistBottomSheet.displayModal(context),
                  child: const ToDoCard(),
                ),
                ColSpacing(24.h)
              ],*/
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ${user?.firstName},',
                          style: theme.headlineSmall,
                        ),
                        ColSpacing(
                          8.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ColSpacing(
                32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: appFeatures
                    .asMap()
                    .entries
                    .map(
                      (e) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tight(
                              Size(MediaQuery.of(context).size.width/2 - 20.w, 200),
                            ),
                            child: AppFeatureCard(feature: e.value),
                          ),),
                    )
                    .toList(),
              ),
              ColSpacing(
                24.h,
              ),
              if (isResident)
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Guests',
                              style: theme.labelLarge?.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.pushNamed(kInvoicesViewRoute),
                              child: const Text('See All'),
                            )
                          ],
                        ),
                        ColSpacing(
                          24.h,
                        ),
                        paymentState.when(
                          data: (state) {
                            final length = state.invoices.length;
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (paymentState.isRefreshing) ...[
                                    loading(),
                                    ColSpacing(24.h)
                                  ],
                                  if (state.invoices.isEmpty)
                                    const EmptyState(
                                      kEmptyHistorySvg,
                                      info:
                                      'You currently have no upcoming payments but when you do, it’ll be here',
                                      isComponentWidget: true,
                                    )
                                  else
                                    ...state.invoices
                                        .getRange(0, length > 2 ? 2 : length)
                                        .map(
                                          (e) => Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 8.h),
                                        child: UpcomingPaymentTile(
                                          item: e,
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ColSpacing(
                                    24.h,
                                  ),
                                ]);
                          },
                          error: (error, _) => Center(
                            child: ErrorState(
                              error: error,
                              retryAction: refreshPaymentData,
                            ),
                          ),
                          loading: () => loading(),
                        ),
                      ],
                    ),
                  ),
                ),
              ColSpacing(
                32.h,
              ),
              if (isResident)
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payments',
                              style: theme.labelLarge?.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.pushNamed(kInvoicesViewRoute),
                              child: const Text('See All'),
                            )
                          ],
                        ),
                        ColSpacing(
                          24.h,
                        ),
                        paymentState.when(
                          data: (state) {
                            final length = state.invoices.length;
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (paymentState.isRefreshing) ...[
                                    loading(),
                                    ColSpacing(24.h)
                                  ],
                                  if (state.invoices.isEmpty)
                                    const EmptyState(
                                      kEmptyHistorySvg,
                                      info:
                                          'You currently have no upcoming payments but when you do, it’ll be here',
                                      isComponentWidget: true,
                                    )
                                  else
                                    ...state.invoices
                                        .getRange(0, length > 2 ? 2 : length)
                                        .map(
                                          (e) => Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child: UpcomingPaymentTile(
                                              item: e,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ColSpacing(
                                    24.h,
                                  ),
                                ]);
                          },
                          error: (error, _) => Center(
                            child: ErrorState(
                              error: error,
                              retryAction: refreshPaymentData,
                            ),
                          ),
                          loading: () => loading(),
                        ),
                      ],
                    ),
                  ),
                ),
              ColSpacing(
                32.h,
              ),
/*              if (!todoComplete && isResident)
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: kWhiteColor),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Checklist progress',
                          style: theme.titleMedium,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            '$checklistPercentage% completed',
                            style: theme.bodySmall,
                          ),
                        ),
                        LinearProgressIndicator(
                          value: checklistPercentage / 100,
                          //borderRadius: BorderRadius.circular(4.r),
                          backgroundColor: kGray4Color,
                        )
                      ],
                    ),
                  ),
                )*/
            ],
          ),
        ),
      ),
    );
  }

  Widget loading() => const Center(child: CircularProgressIndicator());

  Future<void> refreshPaymentData() async =>
      ref.invalidate(paymentStateProvider);
}
