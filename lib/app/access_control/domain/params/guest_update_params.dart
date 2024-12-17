import 'package:mra/app/access_control/data/models/guest.dart';

class GuestUpdateParams {
  final String guestId;
  final String securityId;
  final GuestStatus status;

  GuestUpdateParams(this.guestId, this.securityId, this.status);

  toJson() => {
        "guestId": guestId,
        "securityId": securityId,
        "status": status.stringify
      };
}
