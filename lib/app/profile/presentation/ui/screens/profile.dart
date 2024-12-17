import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/home/data/models/drawer.dart';
import 'package:mra/app/home/presentation/ui/widgets/drawer_item.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStateProvider)!;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56.w,
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
            ),
            child: SvgPicture.asset(
              kBackIconSvg,
            ),
          ),
        ),
        title: const Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            //    ColSpacing(40.h),
            /*       Image.network(
              user.estate.,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.fitWidth,
            ),*/
            ColSpacing(40.h),
            CustomFormField(
              label: 'First Name',
              textField: TextFormField(
                initialValue: user.firstName,
              ),
            ),
            CustomFormField(
              label: 'Last Name',
              textField: TextFormField(
                initialValue: user.lastName,
              ),
            ),
            CustomFormField(
              label: 'Phone Number',
              textField: TextFormField(
                initialValue: user.phoneNumber,
              ),
            ),
            InkWell(
              child: const DrawerItem(
                item: DrawerItemModel(iconPath: kLogoutSvg, title: 'Log out'),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
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
                            Navigator.of(context).pop();
                            ref.read(userStateProvider.notifier).onLogout();
                          },
                        ),
                      ],
                      actionsPadding:
                          const EdgeInsets.symmetric(horizontal: 60),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
