import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData mraDefaultTheme(BuildContext context) => ThemeData(
      fontFamily: 'HankenGrotesk',
      //scaffoldBackgroundColor: kScaffoldBgColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: kButtonBorderRadius,
          foregroundColor: kWhiteColor,
          backgroundColor: kPrimaryColor,
          textStyle: kButtonTextStyle,
          minimumSize: Size(double.maxFinite, 56.h),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: kButtonBorderRadius,
          foregroundColor: kWhiteColor,
          backgroundColor: kPrimaryColor,
          textStyle: kButtonTextStyle,
          minimumSize: Size(double.maxFinite, 56.h),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: kButtonBorderRadius,
          backgroundColor: Colors.transparent,
          foregroundColor: kPrimaryColor,
          minimumSize: Size(double.maxFinite, 56.h),
          textStyle: kButtonTextStyle.copyWith(
            color: kPrimaryBlackColor,
          ),
          side: const BorderSide(color: kPrimaryColor, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kFormFilledColor,
        focusColor: kPrimaryColor,
        contentPadding: EdgeInsets.only(left: 16.w),
        focusedBorder: _defaultBorder.copyWith(
          borderSide: const BorderSide(width: 1),
        ),
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1,
            color: kHelperTextColor),
        errorStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          height: 1.h,
          color: kErrorText,
        ),
        outlineBorder: BorderSide.none,
        border: _defaultBorder,
        enabledBorder: _defaultBorder,
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: kTextTitleColor,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: kHelperTextColor,
        labelColor: kTextTitleColor,
        labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            height: 1.h,
            fontFamily: 'HankenGrotesk'),
        unselectedLabelColor: kHelperTextColor,
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            height: 1.h,
            fontFamily: 'HankenGrotesk'),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: kButtonBorderRadius,
          textStyle: kButtonTextStyle,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: kHelperTextColor,
        thickness: 0.5,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kScaffoldBgColor,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            height: 1.h,
            color: kTextBodyColor),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 6,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kPrimaryColor,
       // backgroundColor: kWhiteColor,
       // unselectedItemColor: kIconColor,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
          kPrimaryColor,
        ),
        trackColor: WidgetStateProperty.all(
          kD5D7D5,
        ),
        radius: Radius.circular(8.r),
      ),
      textTheme: TextTheme(
        displaySmall: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 48.sp,
            height: 1.h,
            color: kTextBodyColor),
        headlineSmall: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            height: 1.4.h,
            color: kTextTitleColor),
        titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            height: 1.h,
            color: kTextBodyColor),
        titleMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            height: 1.5.h,
            color: kTextBodyColor),
        labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            height: 1.h,
            color: kTextBodyColor),
        bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            height: 1.5.h,
            color: kTextBodyColor),
        bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            height: 1.h,
            color: kTextBodyColor),
        bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            height: 1.h,
            color: kTextBodyColor),
      ),
      colorSchemeSeed: kPrimaryColor,
    );

final RoundedRectangleBorder kButtonBorderRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(
    8,
  ),
);
InputBorder _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none);

TextStyle kButtonTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  color: kWhiteColor,
  fontSize: 16.sp,
  height: 1.h,
  fontFamily: 'HankenGrotesk',
);
