import 'package:mra/app/access_control/domain/params/resident_verification_params.dart';
import 'package:mra/app/access_control/presentation/logic/states/resident_verification_state.dart';
import 'package:mra/app/access_control/presentation/ui/widgets/resident_card.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ResidentVerification extends ConsumerStatefulWidget {
  const ResidentVerification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ResidentVerification();
  }
}

class _ResidentVerification extends ConsumerState<ResidentVerification> {
  ResidentVerificationParams? _params;
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
      if (_scrollController.position.pixels > nextPageTrigger) {
        if ((ref
                        .read(residentVerificationStateProvider(_params))
                        .value
                        ?.length ??
                    0) %
                _params!.limit ==
            0) {
          ref
              .read(residentVerificationStateProvider(_params).notifier)
              .fetchMoreResidents();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final residentResult =
        ref.watch(residentVerificationStateProvider(_params));
    ref.listen(residentVerificationStateProvider(_params), (previous, next) {
      if ((previous?.hasValue ?? false) &&
          next is AsyncData &&
          (next.value?.isNotEmpty ?? false)) {
        _params = _params!.incrementPage();
      }
    });
    return Scaffold(
      appBar: AppBar(
        shadowColor: kHelperTextColor,
        title: const Text(
          'Resident Verification',
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(kBackIconSvg),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      kSearchSvg,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints.loose(
                    const Size(40, 40),
                  ),
                  hintText: "Search name of resident"),
              onSubmitted: search,
            ),
            const ColSpacing(32),
            Expanded(
              child: residentResult.when(
                data: (residents) {
                  if (residents.isEmpty) {
                    return const EmptyState(
                      kEmptyResidentSvg,
                      info: "Search resident name to verify their identity",
                    );
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ResidentCard(user: residents[index]),
                      );
                    },
                    itemCount: residents.length,
                  );
                },
                error: (error, __) => ErrorState(error:error),
                loading: () => const LoadingState(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void search(String name) {
    _params = ResidentVerificationParams(name, estateId);
    ref.invalidate(residentVerificationStateProvider);
  }
}
