import 'package:mra/app/home_settings/data/data_source/home_settings_source.dart';
import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/domain/params/personnel_params.dart';
import 'package:mra/app/home_settings/domain/repo/home_settings_repo.dart';
import 'package:mra/app/home_settings/home_settings_providers.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSettingsRepoImplementation extends HomeSettingsRepo {
  final Ref _ref;

  HomeSettingsRepoImplementation(this._ref);

  late final HomeSettingsDataSource _dataSource =
      _ref.read(homeSettingsDataProvider);

  @override
  Future<ApiResult<bool>> createPersonnel(PersonnelParams personnel) {
    return dioInterceptor(() => _dataSource.createPersonnel(personnel));
  }

  @override
  Future<ApiResult<List<Personnel>>> fetchPersonnel(String houseHoldId) {
    return dioInterceptor(() => _dataSource.fetchPersonnel(houseHoldId));
  }

  @override
  Future<ApiResult<bool>> updatePersonnel(Personnel personnel) {
    return dioInterceptor(() => _dataSource.updatePersonnel(personnel));
  }

  @override
  Future<ApiResult<bool>> deletePersonnel(String personnelId) {
    return dioInterceptor(() => _dataSource.deletePersonnel(personnelId));
  }
}
