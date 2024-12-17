import 'package:flutter/painting.dart';

// Ask Tomisin if I should include Color inside the model class
class AppFeatureModel {
  final String title;
  final String description;
  final String showCaseText;
  final Color bgColor;
  final Color borderColor;
  final Function action;

  const AppFeatureModel(
      {required this.title,
      required this.description,
      required this.showCaseText,
      required this.bgColor,
      required this.borderColor,
      required this.action});
}
