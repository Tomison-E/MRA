import 'package:flutter/widgets.dart';

///BOTTOM NAV BAR FOR APP
class BottomNavIcons {
  BottomNavIcons._();

  static const _kFontFam = 'BottomNavIcons';
  static const String? _kFontPkg = null;

  static const IconData home =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData homeActive =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData payment =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData paymentActive =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData chat =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData chatActive =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
