import 'package:mra/app/access_control/presentation/logic/states/guest_verification_state.dart';
import 'package:mra/app/access_control/presentation/ui/widgets/guest_card.dart';
import 'package:mra/core/service_exceptions/service_exception.dart';
import 'package:mra/src/components/flexible_constrained_box.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GuestVerification extends ConsumerStatefulWidget {
  const GuestVerification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GuestVerification();
  }
}

class _GuestVerification extends ConsumerState<GuestVerification> {
  String? _code;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guestResult = ref.watch(guestVerificationStateProvider(_code));
    return FlexibleConstrainedBox(
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
                hintText: "Search guests via access code"),
            controller: _textEditingController,
            onSubmitted: search,
            onChanged: (input) {
              if (input.isEmpty) {
                _code = null;
                ref.invalidate(guestVerificationStateProvider);
              }
            },
          ),
          const ColSpacing(32),
          guestResult.when(
            data: (guest) {
              if (guest == null) {
                return const EmptyState(
                  kEmptyGuestSvg,
                  info: "Search guests by access code",
                );
              }
              return GuestCard(
                  _code!, guest, () => _textEditingController.clear());
            },
            error: (error, __) =>
                ErrorState(message: (error as ApiExceptions).message),
            loading: () => const LoadingState(),
          ),
        ],
      ),
    );
  }

  void search(String code) {
    if (code.isNotEmpty) {
      _code = code;
      ref.invalidate(guestVerificationStateProvider);
    }
  }
}
