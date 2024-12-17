import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/text_fields.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

//todo: change hint to generic texts
class VerifyDetailsBottomSheet extends StatelessWidget {
  const VerifyDetailsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ColSpacing(
              40.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verify your Details',
                style: theme.headlineSmall,
              ),
            ),
            ColSpacing(
              56.h,
            ),
            CustomFormField(
              label: 'Name',
              textField: TextFormField(
                cursorColor: k585666,
              ),
            ),
            CustomFormField(
              label: 'Address',
              textField: TextFormField(
                cursorColor: k585666,
              ),
            ),
            CustomFormField(
              label: 'Phone Number',
              textField: TextFormField(
                cursorColor: k585666,
              ),
            ),
            ColSpacing(
              40.h,
            ),
            CustomFilledButton(
              onPressed: () {
                //todo: add validators for all inputs here

                //pop bottomSheet
                context.pop();
                //go to create account screen
                context.goNamed(kCreateAccountRoute);
              },
              buttonText: 'Yes, this is me',
            ),
            ColSpacing(
              40.h,
            ),
            Text(
              'If details are incorrect please reach to your estate admin',
              style: theme.bodyLarge,
            ),
            ColSpacing(
              64.h,
            ),
          ],
        ),
      ),
    );
  }

  static void displayModal(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kWhiteColor,
        constraints: BoxConstraints.tightFor(height: 691.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        builder: (context) => const VerifyDetailsBottomSheet(),);
  }
}
