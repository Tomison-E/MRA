import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/presentation/logic/states/active_alert_state.dart';
import 'package:mra/app/alert/presentation/logic/states/alert_state.dart';
import 'package:mra/app/alert/presentation/logic/states/inactive_alert_state.dart';
import 'package:mra/app/alert/presentation/ui/widgets/alert_card.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertHistory extends ConsumerStatefulWidget {
  const AlertHistory({super.key, required this.type});

  final AlertHistoryType type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AlertHistory();
  }
}

class _AlertHistory extends ConsumerState<AlertHistory> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late AlertHistoryParams _params = AlertHistoryParams(_fetchStatus, estateId);
  final ScrollController _scrollController = ScrollController();
  late String estateId = ref.read(userStateProvider)!.estate.id;
  late final nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

  @override
  void initState() {
    scrollListener();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    _scrollController.addListener(() {
      // print(_scrollController.position.pixels);
      //print(nextPageTrigger);
      if (_scrollController.position.pixels > nextPageTrigger) {
        // print((ref.read(_fetchProvider(_params)).value?.length ?? 0));
        if ((ref.read(_fetchProvider(_params)).value?.length ?? 0) %
                _params.limit ==
            0) {
          //   print("i");
          fetchMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final alertState = ref.watch(_fetchProvider(_params));
    ref.listen(_fetchProvider(_params), (previous, next) {
      if ((previous?.hasValue ?? false) &&
          next is AsyncData &&
          (next.value?.isNotEmpty ?? false)) {
        _params = _params.incrementPage();
      }
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
      child: alertState.when(
        data: (alerts) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: alerts.isEmpty
                ? const EmptyState(
                    kEmptyAlertSvg,
                    info:
                        'You currently have no unresponded alerts but when you do, it’ll be here',
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: AlertCard(alerts[index], widget.type, _params),
                      );
                    },
                    itemCount: alerts.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
          );
        },
        error: (error, __) => ErrorState(error:error),
        loading: () => const LoadingState(),
      ),
    );
  }

  Future<void> _refresh() async {
    _params = AlertHistoryParams(_fetchStatus, estateId);
    ref.invalidate(_fetchProvider);
  }

  AsyncNotifierProviderFamily get _fetchProvider {
    switch (widget.type) {
      case AlertHistoryType.active:
        return activeAlertStateProvider;
      case AlertHistoryType.unResponded:
        return inactiveAlertStateProvider;
      case AlertHistoryType.all:
        return alertStateProvider;
    }
  }

  AlertStatus? get _fetchStatus {
    switch (widget.type) {
      case AlertHistoryType.active:
        return AlertStatus.active;
      case AlertHistoryType.unResponded:
        return AlertStatus.pending;
      case AlertHistoryType.all:
        return null;
    }
  }

  void fetchMore() {
    switch (widget.type) {
      case AlertHistoryType.active:
        ref.read(activeAlertStateProvider(_params).notifier).fetchMoreAlerts();
        break;
      case AlertHistoryType.unResponded:
        ref
            .read(inactiveAlertStateProvider(_params).notifier)
            .fetchMoreAlerts();
        break;
      case AlertHistoryType.all:
        ref.read(alertStateProvider(_params).notifier).fetchMoreAlerts();
        break;
    }
  }
}

enum AlertHistoryType { unResponded, active, all }
