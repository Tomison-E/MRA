import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/home/data/models/drawer.dart';
import 'package:mra/app/home/presentation/ui/widgets/drawer_item.dart';
import 'package:mra/src/components/dialogs/coming_soon_dialog.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    final theme = Theme.of(context).textTheme;
    return Drawer(
      width: 306.w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.w),
            child: Column(
              children: [
                ColSpacing(
                  65.h,
                ),
                Row(
                  children: [
                    if (user?.profileImageUrl != null)
                      Image.network(
                        user!.profileImageUrl!,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.fitWidth,
                      ),
                    RowSpacing(
                      18.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                          style: theme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                          onTap: () => context.pushNamed(kEditProfileRoute),
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: Text(
                              'Profile',
                              style: theme.labelLarge?.copyWith(
                                color: kPrimaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          //DIVIDER
          Padding(
            padding: EdgeInsets.only(top: 24.h, bottom: 40.h),
            child: const Divider(
              thickness: 4,
              height: 0,
              color: kGray4Color,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _drawerItems
                  .asMap()
                  .entries
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        switch (e.key) {
                          case 0:
                            context.pushNamed(kHomeSettingsRoute);
                            break;
                          case 1:
                            context.pushNamed(kAccessControlRoute);
                            break;
                          case 2:
                            context.pushNamed(kNoticeBoardRoute);
                            break;
                          case 3:
                            context.pushNamed(kServicesRoute);
                            break;
                          case 4:
                            context.pushNamed(kAlertRoute);
                            break;
                          case 5:
                          case 6:
                            ComingSoonDialog.display(context);
                            break;
                          case 7:
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  title: const Text('You\'re about to log out'),
                                  content: const Text('Are you sure?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Logout'),
                                      onPressed: () {
                                        ref
                                            .read(userStateProvider.notifier)
                                            .onLogout();
                                      },
                                    ),
                                  ],
                                  actionsPadding: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                );
                              },
                            );
                            break;
                        }
                      },
                      child: DrawerItem(item: e.value),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

const List<DrawerItemModel> _drawerItems = [
  DrawerItemModel(iconPath: kDrawerAccessControlSvg, title: 'Access Control'),
  DrawerItemModel(iconPath: kHomeSettingsSvg, title: 'House Configuration'),
  DrawerItemModel(iconPath: kNoticeBoardSvg, title: 'Announcements'),
  DrawerItemModel(iconPath: kLogoutSvg, title: 'Log 0ut'),
];
