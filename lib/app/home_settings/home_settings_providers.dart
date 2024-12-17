import 'package:mra/app/home_settings/data/data_source/home_settings_source.dart';
import 'package:mra/app/home_settings/data/data_source/home_settings_source_impl.dart';
import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/data/repo_impl/home_settings_repo_impl.dart';
import 'package:mra/app/home_settings/domain/repo/home_settings_repo.dart';
import 'package:mra/app/home_settings/presentation/logic/states/household_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeSettingsDataProvider = Provider<HomeSettingsDataSource>((ref) {
  return HomeSettingsDataSourceImplementation(ref);
});

final homeSettingsRepoProvider = Provider<HomeSettingsRepo>((ref) {
  return HomeSettingsRepoImplementation(ref);
});

final houseHoldStateProvider =
    AsyncNotifierProvider<HouseHoldState, List<Personnel>>(
        () => HouseHoldState());
