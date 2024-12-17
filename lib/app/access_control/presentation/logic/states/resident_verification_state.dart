import 'dart:async';

import 'package:mra/app/access_control/domain/params/resident_verification_params.dart';
import 'package:mra/app/access_control/domain/use_cases/access_control_use_cases.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResidentVerificationState
    extends FamilyAsyncNotifier<List<User>, ResidentVerificationParams?> {
  @override
  FutureOr<List<User>> build(arg) async {
    return fetchResidents();
  }

  FutureOr<List<User>> fetchResidents() async {
    if (arg == null) return [];
    return (await ref.read(residentVerificationUseCaseProvider(arg!)))
        .extract();
  }

  Future<ApiResult<List<User>>> fetchMoreResidents() async {
    final members = state.value;
    final value = await ref
        .read(residentVerificationUseCaseProvider(arg!.incrementPage()));
    value.when(
      success: (value) async {
        state = const AsyncLoading();
        members?.addAll(value);
        state = AsyncData(members!);
      },
      apiFailure: (_, __) => state = AsyncData(members ?? []),
    );
    return value;
  }
}

final residentVerificationStateProvider = AsyncNotifierProviderFamily<
    ResidentVerificationState,
    List<User>,
    ResidentVerificationParams?>(() => ResidentVerificationState());
