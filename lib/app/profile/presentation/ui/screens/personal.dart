import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/profile/presentation/logic/methods/file_upload.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class PersonalTabView extends ConsumerStatefulWidget {
  const PersonalTabView({super.key});

  @override
  ConsumerState<PersonalTabView> createState() => _PersonalTabViewState();
}

class _PersonalTabViewState extends ConsumerState<PersonalTabView> with FileUpload {
  String? prevUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final user = ref.watch(userStateProvider)!;
    prevUrl = user.profileImageUrl;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ColSpacing(40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              user.profileImageUrl != null
                  ? Image.network(
                      user.profileImageUrl!,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      kProfileIconSvg,
                      width: 80.w,
                    ),
              SvgPicture.asset(
                kBarcodeSvg,
                width: 32.w,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 16.h,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomTextButton(
                onPressed: fetchImg,
                buttonText: 'Upload Picture',
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text:
                      'You can only change your picture with this form. To change your personal information please ',
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      context.goNamed(kChatRoute);
                    },
                    child: Text(
                      "chat",
                      style: theme.bodyLarge?.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: ' with your estate admin'),
              ],
            ),
            style: theme.bodyLarge?.copyWith(
              fontSize: 15.sp,
              color: kHelperTextColor,
            ),
          ),
          ColSpacing(
            40.h,
          ),
          CustomFormField(
            label: 'First Name',
            textField: TextFormField(
              initialValue: user.firstName,
              readOnly: true,
            ),
          ),
          CustomFormField(
            label: 'Last Name',
            textField: TextFormField(
              initialValue: user.lastName,
              readOnly: true,
            ),
          ),
          CustomFormField(
            label: 'Phone Number',
            textField: TextFormField(
              initialValue: user.phoneNumber,
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  void fetchImg() async {
    Loader.show(context);
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      uploadImg(result);
    } else if (mounted) {
      Loader.hide();
      Toast.error("Upload failed", context);
    }
/*    } on PlatformException catch (_) {
      if (await Permission.manageExternalStorage.status ==
          PermissionStatus.denied) {
        PermissionDialog.display(context, "device files");
      }
    }*/
  }

  void uploadImg(XFile file) async {
      if (!isValidFileSize(await file.readAsBytes(), context)) {
        Loader.hide();
        return;
      }
    final response = await ref.read(userStateProvider.notifier).uploadImg(file);
    response.when(
      success: (_) {
        Toast.success("Image Uploaded successfully", context);
/*        if (ref.read(userStateProvider)!.todoComplete && prevUrl == null) {
          context
            ..pop()
            ..pop();
          context.pushNamed(kOnBoardingCompleteRoute);
        }*/
      },
      apiFailure: (error, _) => Toast.apiError(error, context),
    );
    Loader.hide();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
