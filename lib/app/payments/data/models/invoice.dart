import 'package:mra/src/extensions/strings.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice{
  final String id;
  final num amount;
  final InvoiceStatus status;
  @JsonKey(name: 'paymentType')
  final PaymentType type;

  const Invoice(this.id, this.status, this.type, this.amount);

  get title => type.name.capitalize;

  factory Invoice.fromJson(Map<String, Object?> json) =>
      _$InvoiceFromJson(json);

  Map<String, Object?> toJson() => _$InvoiceToJson(this);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum InvoiceStatus { open, pending, overdue, paid }

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum PaymentType { due, subscription, rent }

extension IconName on PaymentType {
  String get icon => switch (this) {
        PaymentType.due => kEstateDuesSvg,
        PaymentType.rent => kTaxLevySvg,
        PaymentType.subscription => kInternetSvg,
      };
}
