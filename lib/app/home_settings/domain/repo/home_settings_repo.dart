import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/domain/params/personnel_params.dart';
import 'package:mra/core/service_result/service_result.dart';

abstract class HomeSettingsRepo {
  Future<ApiResult<bool>> createPersonnel(PersonnelParams personnel);
  Future<ApiResult<bool>> updatePersonnel(Personnel personnel);
  Future<ApiResult<List<Personnel>>> fetchPersonnel(String houseHoldId);
  Future<ApiResult<bool>> deletePersonnel(String personnelId);
}
