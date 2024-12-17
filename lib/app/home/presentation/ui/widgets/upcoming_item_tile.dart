import 'package:mra/app/home/data/models/upcoming_item.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpcomingItemTile extends StatelessWidget {
  final UpcomingItemModel item;

  const UpcomingItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: kF3F3F3, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(item.iconPath),
              title: Text(item.title),
              trailing: CustomTextButton(
                onPressed: () {},
                buttonText: item.actionText,
                style: TextButton.styleFrom(
                    foregroundColor: item.type == UpcomingItemType.alert
                        ? kErrorText
                        : null),
              ),
            ),
          ),
        ),
        const ColSpacing(8)
      ],
    );
  }
}
