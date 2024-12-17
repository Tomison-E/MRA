import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/domain/params/personnel_params.dart';
import 'package:mra/app/home_settings/home_settings_providers.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createPersonnelUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<bool>>, PersonnelParams>(
  (ref, arg) => UseCase<bool>()
      .call(() => ref.read(homeSettingsRepoProvider).createPersonnel(arg)),
);

final updatePersonnelUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<bool>>, Personnel>(
  (ref, arg) => UseCase<bool>()
      .call(() => ref.read(homeSettingsRepoProvider).updatePersonnel(arg)),
);

final fetchPersonnelUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<List<Personnel>>>, String>(
  (ref, arg) => UseCase<List<Personnel>>()
      .call(() => ref.read(homeSettingsRepoProvider).fetchPersonnel(arg)),
);

final deletePersonnelUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<bool>>, String>(
  (ref, arg) => UseCase<bool>()
      .call(() => ref.read(homeSettingsRepoProvider).deletePersonnel(arg)),
);
