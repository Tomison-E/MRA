import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment.g.dart';

 @JsonSerializable()
class Payment {
  final List<Invoice> invoices;
  final List<Invoice> transactions;

  Payment(this.invoices, this.transactions);

  factory Payment.fromJson(Map<String, Object?> json) =>
      _$PaymentFromJson(json);

  Map<String, Object?> toJson() => _$PaymentToJson(this);
}