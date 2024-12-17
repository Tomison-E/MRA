import 'package:mra/app/home_settings/data/models/personnel.dart';

class PersonnelParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? houseHoldId;
  final PersonnelType type;

  PersonnelParams(this.firstName, this.lastName, this.phoneNumber,
      this.houseHoldId, this.type);

  toJson() => <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'householdId': houseHoldId,
        'type': type.name.toUpperCase(),
      };
}
