import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/images/images.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanQRBottomSheet extends StatelessWidget {
  const ScanQRBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ScanQRSheet();
  }

  static void displayModal(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhiteColor,
      useRootNavigator: true,
      constraints:
          BoxConstraints.tightFor(height: 739.h, width: double.maxFinite),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => const ScanQRBottomSheet(),
    );
  }
}

class _ScanQRSheet extends StatefulWidget {
  const _ScanQRSheet();

  @override
  State<_ScanQRSheet> createState() => _ScanQRSheetState();
}

class _ScanQRSheetState extends State<_ScanQRSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ColSpacing(72.h),
          Text(
            'Scan QR Code',
            style: theme.titleLarge,
          ),
          ColSpacing(16.h),
          const Text('Get your QR code scanned to verify your ID'),
          ColSpacing(40.h),
          Image.asset(kBarcodeImg),

        ],
      ),
    );
  }
}
