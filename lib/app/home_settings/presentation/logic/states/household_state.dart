import 'dart:async';

import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/domain/params/personnel_params.dart';
import 'package:mra/app/home_settings/domain/use_cases/home_settings_use_cases.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseHoldState extends AsyncNotifier<List<Personnel>> {
  HouseHoldState();

  FutureOr<List<Personnel>> _getHouseHoldPersonnel(String houseHoldId) async {
    return (await ref.read(fetchPersonnelUseCaseProvider(houseHoldId)))
        .extract();
  }

  Future<ApiResult> createPersonnel(PersonnelParams personnel) async {
    final members = state.asData?.value;
    final value = await ref.read(createPersonnelUseCaseProvider(personnel));
    value.when(
      success: (value) async {
        state = const AsyncLoading();
        state = AsyncData(
          await _getHouseHoldPersonnel(personnel.houseHoldId!),
        );
      },
      apiFailure: (_, __) => state = AsyncData(members ?? []),
    );
    return value;
  }

  Future<ApiResult> deletePersonnel(String personnelId) async {
    final houseMembers = state.asData?.value ?? [];
    final value = await ref.read(deletePersonnelUseCaseProvider(personnelId));
    value.whenOrNull(
      success: (value) {
        houseMembers.removeWhere((element) => element.id == personnelId);
        state = AsyncData(houseMembers);
      },
    );
    return value;
  }

  @override
  FutureOr<List<Personnel>> build() async {
    return _getHouseHoldPersonnel(ref.watch(userStateProvider)!.houseHold.householdId);
  }
}
