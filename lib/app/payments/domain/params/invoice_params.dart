import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:equatable/equatable.dart';

class InvoiceParams extends Equatable {
  final String userId;
  final InvoiceStatus status;
  final int page;
  final int limit;

  const InvoiceParams(this.userId, this.status,
      [this.page = 1, this.limit = 10]);

  InvoiceParams incrementPage() {
    return InvoiceParams(userId, status, page + 1, limit);
  }

  factory InvoiceParams.upcoming (String userId,[int page = 1, int limit = 10])=> InvoiceParams(userId, InvoiceStatus.pending,page,limit);

  factory InvoiceParams.transactions (String userId,[int page = 1, int limit = 10])=> InvoiceParams(userId, InvoiceStatus.paid,page,limit);

  Map<String,dynamic> toJson() =>
      {"invoiceStatus": status.name.toUpperCase(), "userId": userId, "page": page, "limit": limit};

  @override
  List<Object?> get props => [page,status];
}
