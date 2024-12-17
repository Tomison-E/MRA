import 'package:equatable/equatable.dart';

class ResidentVerificationParams extends Equatable {
  final String name;
  final String estateId;
  final int page;
  final int limit;

  const ResidentVerificationParams(this.name, this.estateId,
      [this.limit = 10, this.page = 1]);

  Map<String, dynamic> toMap() {
    return {"name": name, "estateId": estateId, "limit": limit, "page": page};
  }

  ResidentVerificationParams incrementPage() {
    return ResidentVerificationParams(name, estateId, limit, page + 1);
  }

  @override
  List<Object?> get props => [name, estateId, limit];
}
