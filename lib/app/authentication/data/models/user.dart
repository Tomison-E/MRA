import 'package:mra/app/authentication/data/models/estate.dart';
import 'package:mra/app/authentication/data/models/locale.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String firstName;
  final String lastName;
  @JsonKey(name: "_id")
  final String id;
  final String phoneNumber;
  final String? profileImageUrl;
  final UserType role;
  final bool hasPin;
  final List<HouseHold> addresses;
  @JsonKey(defaultValue: Country.ng)
  final Country countryCode;
  late final UserLocale locale = setLocalization();

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  User(
      this.firstName,
      this.lastName,
      this.id,
      this.phoneNumber,
      this.profileImageUrl,
      this.hasPin,
      this.addresses,
      this.countryCode,
      this.role,);

  Map<String, Object?> toJson() => _$UserToJson(this);

  setLocalization() => UserLocale.getLocality(countryCode);

  HouseHold get houseHold => addresses.first;
  Estate get estate => Estate("name", "address", [], id, "managerId");
  bool get isResident => role == UserType.resident;
}

enum Country { ng, gh }

@JsonEnum(fieldRename: FieldRename.none)
enum UserType { resident, security, estateManager }
