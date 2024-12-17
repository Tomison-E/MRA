import 'package:mra/app/notice_board/notice_board_providers.dart';
import 'package:mra/app/notice_board/presentation/ui/widgets/notice_board_card.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NoticeBoardScreen extends ConsumerStatefulWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NoticeBoard();
  }
}

class _NoticeBoard extends ConsumerState<NoticeBoardScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notice Board',
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(kBackIconSvg),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
        child: Consumer(builder: (context, ref, _) {
          final announcementState = ref.watch(announcementStateProvider);
          return announcementState.when(
            data: (announcements) {
              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: announcements.isEmpty
                    ? const EmptyState(
                        kEmptyNoticeSvg,
                        info:
                            'When your estate admin announces something it will be posted here',
                      )
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: NoticeBoardCard(
                              announcement: announcements[index],
                            ),
                          );
                        },
                        itemCount: announcements.length,
                      ),
              );
            },
            error: (error, __) => ErrorState(error: error),
            loading: () => const LoadingState(),
          );
        }),
      ),
    );
  }

  Future<void> _refresh() async {
    ref.invalidate(announcementStateProvider);
  }
}
