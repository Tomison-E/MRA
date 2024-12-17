// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      json['id'] as String,
      $enumDecode(_$InvoiceStatusEnumMap, json['status']),
      $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      json['amount'] as num,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': _$InvoiceStatusEnumMap[instance.status]!,
      'paymentType': _$PaymentTypeEnumMap[instance.type]!,
    };

const _$InvoiceStatusEnumMap = {
  InvoiceStatus.open: 'OPEN',
  InvoiceStatus.pending: 'PENDING',
  InvoiceStatus.overdue: 'OVERDUE',
  InvoiceStatus.paid: 'PAID',
};

const _$PaymentTypeEnumMap = {
  PaymentType.due: 'DUE',
  PaymentType.subscription: 'SUBSCRIPTION',
  PaymentType.rent: 'RENT',
};
