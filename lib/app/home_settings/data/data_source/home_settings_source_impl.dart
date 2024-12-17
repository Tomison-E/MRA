import 'package:mra/app/home_settings/data/data_source/home_settings_source.dart';
import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/domain/params/personnel_params.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSettingsDataSourceImplementation extends HomeSettingsDataSource {
  final Ref _ref;

  HomeSettingsDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);
  final personnel = "personnels";

  @override
  Future<bool> createPersonnel(PersonnelParams personnel) async {
    await _apiClient.post(kPersonnelRoute, data: personnel.toJson());
    return true;
  }

  @override
  Future<List<Personnel>> fetchPersonnel(String houseHoldId) async {
    final response =
        await _apiClient.get("$kHouseHoldRoute/$houseHoldId/$personnel");
    return (response.data["data"] as List<dynamic>)
        .map((e) => Personnel.fromJson(e))
        .toList();
  }

  @override
  Future<bool> updatePersonnel(Personnel personnel) async {
    await _apiClient.put(kPersonnelRoute, data: personnel.toJson());
    return true;
  }

  @override
  Future<bool> deletePersonnel(String personnelId) async {
    await _apiClient.delete("$kPersonnelRoute/$personnelId");
    return true;
  }
}
