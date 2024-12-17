// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['id'] as String,
      json['amount'] as num,
      json['fee'] as num,
      (json['invoiceIds'] as List<dynamic>).map((e) => e as String).toList(),
      json['trx_ref'] as String,
      $enumDecode(_$TransactionStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'fee': instance.fee,
      'invoiceIds': instance.invoiceIds,
      'trx_ref': instance.reference,
      'status': _$TransactionStatusEnumMap[instance.status]!,
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.failed: 'FAILED',
  TransactionStatus.pending: 'PENDING',
  TransactionStatus.paid: 'PAID',
};
