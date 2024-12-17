class GuestParams {
  final String houseHoldId;
  final String name;
  final String phoneNumber;

  GuestParams(this.houseHoldId, this.name, this.phoneNumber);

  toInviteGuestJson() => {
        'householdId': houseHoldId,
        'name': name,
        'phoneNumber': phoneNumber,
      };
}
