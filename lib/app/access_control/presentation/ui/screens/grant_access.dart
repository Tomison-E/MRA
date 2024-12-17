import 'package:mra/app/access_control/presentation/logic/states/guest_state.dart';
import 'package:mra/app/access_control/presentation/ui/modals/invite_guest.dart';
import 'package:mra/app/access_control/presentation/ui/widgets/empty_guest_access.dart';
import 'package:mra/app/access_control/presentation/ui/widgets/invited_guest_card.dart';
import 'package:mra/core/service_exceptions/service_exception.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/extensions/dates.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GrantAccess extends ConsumerStatefulWidget {
  const GrantAccess({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GrantAccess();
  }
}

class _GrantAccess extends ConsumerState<GrantAccess> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final invitedGuest = ref.watch(guestStateProvider);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: invitedGuest.when(
          data: (guests) {
            DateTime? currentDate = guests.firstOrNull?.createdAt;
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: guests.isEmpty
                  ? const EmptyGuestWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Text(
                            currentDate!.toGroupName(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: kHelperTextColor),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(bottom: 30.h),
                                    child: InvitedGuestCard(
                                      guest: guests[index],
                                    ),
                                  ),
                              separatorBuilder: (context, index) {
                                if (guests[index]
                                    .createdAt
                                    .isSameDay(currentDate!)) {
                                  return const SizedBox.shrink();
                                }
                                currentDate = guests[index].createdAt;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Text(
                                    currentDate!.toGroupName(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: kHelperTextColor),
                                  ),
                                );
                              },
                              itemCount: guests.length),
                        ),
                        ColSpacing(
                          20.h,
                        ),
                        CustomFilledButton(
                          onPressed: () =>
                              InviteGuestBottomSheet.displayModal(context),
                          buttonText: 'Invite Guest',
                        ),
                      ],
                    ),
            );
          },
          error: (error, __) => ErrorState(
            message: error is ApiExceptions ? error.message : error.toString(),
          ),
          loading: () => const LoadingState(),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    ref.invalidate(guestStateProvider);
  }
}
