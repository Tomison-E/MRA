import 'package:mra/src/res/values/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyView extends StatelessWidget {
  final num amount;
  final String currency;
  final TextStyle? symbolStyle;
  final TextStyle? amountStyle;
  final int decimalDigits;

  const CurrencyView(
      this.amount,
      {super.key,
        this.currency = 'NGN',
        this.symbolStyle,
        this.amountStyle,
        this.decimalDigits = 2,
      });

  TextStyle? _getSymbolStyle(BuildContext context) {
    return (symbolStyle ?? amountStyle)
        ?.copyWith(fontFamily: kDefaultSymbolFont) ??
        Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontFamily: kDefaultSymbolFont);
  }

  static String value(BuildContext context, num amount, String currency,
      [int decimalDigits = 2]) {
    final NumberFormat formatter = _formatter(context, decimalDigits);
    return "${formatter.simpleCurrencySymbol(currency)}${formatter.format(amount)}";
  }

  static String currencySymbol(BuildContext context, String currency) {
    return _formatter(context).simpleCurrencySymbol(currency);
  }

  static NumberFormat _formatter(BuildContext context,
      [int decimalDigits = 2]) =>
      NumberFormat.currency(
          decimalDigits: decimalDigits,
          locale: Localizations.localeOf(context).toString(),
          name: "");

  static String formattedAmount(BuildContext context, num amount,
      [int decimalDigits = 2]) {
    return _formatter(context, decimalDigits).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.currency(
        decimalDigits: decimalDigits,
        locale: Localizations.localeOf(context).toString(),
        name: "");

    return Text.rich(
      TextSpan(
        text: "",
        children: [
          TextSpan(
            text: formatter.simpleCurrencySymbol(currency),
            style: _getSymbolStyle(context),
          ),
          TextSpan(
            text: formatter.format(amount),
            style: amountStyle ?? Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
      maxLines: 1,
    );
  }
}
