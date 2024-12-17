import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/src/utils/functions/functions.dart';

class MessageCard extends StatelessWidget {
  final MessageCardParams params;
  const MessageCard({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Align(
        alignment:
            params.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 275.w, minWidth: 70.w),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: params.sentByMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(15),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(5),
                      ),
                border:
                    params.sentByMe ? null : Border.all(color: kLightGrayColor),
                color: params.sentByMe ? kBlueColor : kWhiteColor),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 32.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!params.sentByMe)
                          Text(
                            "Access Control Chat Room",
                            textAlign: TextAlign.left,
                            style: theme.titleLarge?.copyWith(
                                color: kBlueColor,
                                fontSize: 14.sp,
                                height: 1.5.h),
                          ),
                        const ColSpacing(4),
                        Text(
                          params.chatMessage,
                          style: theme.bodyLarge?.copyWith(
                              fontSize: 14.sp,
                              color:
                                  params.sentByMe ? kWhiteColor : kBlackColor),
                        ),
                      ],
                    ),
                  ),
                  const ColSpacing(4),
                  if (params.optionsArgs?.options.isNotEmpty ?? false)
                    OptionsTile(params: params.optionsArgs!)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageCardParams {
  final String chatMessage;
  final bool sentByMe;
  final OptionsParams? optionsArgs;

  MessageCardParams(
      {required this.chatMessage, required this.sentByMe, this.optionsArgs});
}

class OptionsParams {
  final String? selected;
  final ValueChanged<String> onSelected;
  final List<String> options;

  OptionsParams(
      {this.selected, required this.onSelected, required this.options});
}

class OptionsTile extends StatelessWidget {
  const OptionsTile({super.key, required this.params});

  final OptionsParams params;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: mapIndexed(
        params.options,
        (index, e) {
          final isSelected = params.selected == e;
          print(isSelected);
          print(params.selected);
          print(e);

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primaryContainer.withOpacity(0.4)
                    : theme.colorScheme.onPrimary,
                border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onInverseSurface),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.only(right: 16),
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                value: isSelected,
                onChanged: (_) => params.onSelected(e),
                side: const BorderSide(width: 0.7),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        e,
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                activeColor: theme.colorScheme.primary,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
