import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/domain/params/personnel_params.dart';

abstract class HomeSettingsDataSource {
  Future<bool> createPersonnel(PersonnelParams personnel);
  Future<bool> updatePersonnel(Personnel personnel);
  Future<bool> deletePersonnel(String personnelId);
  Future<List<Personnel>> fetchPersonnel(String houseHoldId);
}
