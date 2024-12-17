//to distinguish between the payments and action buttons
import 'package:mra/src/res/assets/assets.dart';

enum UpcomingItemType { approval, payment, alert }

class UpcomingItemModel {
  const UpcomingItemModel({required this.type, required this.title});

  final String title;
  final UpcomingItemType type;

  String get iconPath => _icon(type);

  String get actionText => _action(type);
}

//iconSelector

String _icon(UpcomingItemType itemType) {
  switch (itemType) {
    case UpcomingItemType.approval:
      return kDocumentSvg;
    case UpcomingItemType.payment:
      return kClockSvg;
    case UpcomingItemType.alert:
      return kClockSvg;
  }
}

String _action(UpcomingItemType itemType) {
  switch (itemType) {
    case UpcomingItemType.approval:
      return 'Review';
    case UpcomingItemType.payment:
      return 'Pay now';
    case UpcomingItemType.alert:
      return 'Respond';
  }
}
