import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';

class OnBoardingPageIndicator extends StatelessWidget {
  const OnBoardingPageIndicator(
      {Key? key, required this.currentPage, required this.totalPages,})
      : super(key: key);
  final int currentPage;
  final int totalPages;

  Color _getColor(index) => index == currentPage ? kPrimaryBlackColor : kD9D9D9;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        totalPages,
        (index) => TabPageSelectorIndicator(
          backgroundColor: _getColor(index),
          size: 8,
          borderColor: _getColor(index),
        ),
      ),
    );
  }
}
