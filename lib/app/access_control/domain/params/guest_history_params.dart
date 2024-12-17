import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:equatable/equatable.dart';

class GuestHistoryParams extends Equatable {
  final GuestStatus status;
  final String estateId;
  final int page;
  final int limit;
  final bool isStatus;

  const GuestHistoryParams(this.status, this.estateId, this.isStatus,
      {this.page = 1, this.limit = 20});

  Map<String, Object?> toJson() => <String, Object?>{
        if (isStatus)
          'status': status.stringify
        else
          'statusIsNot': status.stringify,
        'estateId': estateId,
        'page': page,
        'limit': limit,
      };

  @override
  List<Object?> get props => [estateId, page, limit];
}
