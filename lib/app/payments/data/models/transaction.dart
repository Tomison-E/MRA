import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction{
  final String id;
  final num amount;
  final num fee;
  final List<String> invoiceIds;
  @JsonKey(name: 'trx_ref')
  final String reference;
  final TransactionStatus status;


  factory Transaction.fromJson(Map<String, Object?> json) =>
      _$TransactionFromJson(json);

  Transaction(this.id, this.amount, this.fee, this.invoiceIds, this.reference, this.status);

  Map<String, Object?> toJson() => _$TransactionToJson(this);

}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TransactionStatus {failed, pending, paid }
extension Naming on TransactionStatus{
  String get name => switch(this){
    TransactionStatus.failed => "Failed",
  TransactionStatus.paid => "Successful",
    TransactionStatus.pending => "Pending"
  };
}