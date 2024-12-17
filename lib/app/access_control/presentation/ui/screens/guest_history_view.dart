import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_history_params.dart';
import 'package:mra/app/access_control/presentation/logic/states/guest_state.dart';
import 'package:mra/app/access_control/presentation/ui/widgets/guest_history_card.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/extensions/dates.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestHistoryView extends ConsumerStatefulWidget {
  const GuestHistoryView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GuestHistoryView();
  }
}

class _GuestHistoryView extends ConsumerState<GuestHistoryView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final guestHistory = ref.watch(guestHistoryProvider(GuestHistoryParams(
        GuestStatus.pending, ref.read(userStateProvider)!.estate.id, false)));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColSpacing(40.h),
            Expanded(
              child: guestHistory.when(
                data: (guests) {
                  if (guests.isEmpty) {
                    return const EmptyState(
                      kEmptyHistorySvg,
                      info:
                          'You currently have no guest history but when you do, it’ll be here',
                    );
                  }
                  DateTime currentDate = guests.first.createdAt;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Text(
                          currentDate.toGroupName(),
                          style: theme.labelLarge
                              ?.copyWith(color: kHelperTextColor),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(bottom: 30.h),
                                  child: GuestHistoryCard(guest: guests[index]),
                                ),
                            separatorBuilder: (context, index) {
                              if (guests[index]
                                  .createdAt
                                  .isSameDay(currentDate)) {
                                return const SizedBox.shrink();
                              }
                              currentDate = guests[index].createdAt;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: Text(
                                  currentDate.toGroupName(),
                                  style: theme.labelLarge
                                      ?.copyWith(color: kHelperTextColor),
                                ),
                              );
                            },
                            itemCount: guests.length),
                      )
                    ],
                  );
                },
                error: (error, __) => ErrorState(error: error),
                loading: () => const LoadingState(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    ref.invalidate(guestHistoryProvider);
  }
}
