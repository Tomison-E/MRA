import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResidentCard extends StatelessWidget {
  const ResidentCard({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 88.h,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.network(
                "user.profileImageUrl!",
                width: 50.w,
                height: 50.h,
                fit: BoxFit.fitWidth,
              ),
              const RowSpacing(16),
              Column(
                children: [
                  Text("${user.firstName} ${user.lastName}",
                      style: textTheme.labelLarge),
                  const ColSpacing(16),
                  Text(user.houseHold.houseNumber,
                      style: textTheme.bodyMedium),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
