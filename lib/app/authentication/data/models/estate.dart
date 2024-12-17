import 'package:json_annotation/json_annotation.dart';

part 'estate.g.dart';

//todo
@JsonSerializable()
class Estate {
  final String name;
  final String address;
  final List<HouseHold> households;
  final String id;
  final String managerId;
  factory Estate.fromJson(Map<String, Object?> json) => _$EstateFromJson(json);

  Estate(this.name, this.address, this.households, this.id, this.managerId);

  Map<String, Object?> toJson() => _$EstateToJson(this);
}

@JsonSerializable()
class HouseHold {
  final String houseNumber;
  final String householdId;

  factory HouseHold.fromJson(Map<String, Object?> json) =>
      _$HouseHoldFromJson(json);

  HouseHold(this.houseNumber,this.householdId);

  Map<String, Object?> toJson() => _$HouseHoldToJson(this);
}
