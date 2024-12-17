import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/domain/params/set_password_params.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/text_fields.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/components/will_pop/will_pop.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:mra/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  const CreateAccountScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final ValueNotifier<bool> _enableBiometrics = ValueNotifier<bool>(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return WillPop(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                ColSpacing(120.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create your DEMS\naccount',
                    style: theme.headlineSmall,
                  ),
                ),
                ColSpacing(
                  56.h,
                ),
                CustomFormField(
                  label: 'Phone Number',
                  textField: TextFormField(
                    cursorColor: k585666,
                    initialValue: widget.phoneNumber,
                    readOnly: true,
                  ),
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate,
                  child: Column(
                    children: [
                      CustomFormField(
                        label: 'Create Password',
                        textField: CustomPasswordTextField(
                          textController: _editingController,
                          validator: (input) =>
                              Validators.validatePassword(input),
                        ),
                      ),
                      CustomFormField(
                        label: 'Confirm Password',
                        textField: CustomPasswordTextField(
                          validator: (input) => Validators.confirmPassword(
                              input, _editingController.text),
                        ),
                      ),
                    ],
                  ),
                ),
                ColSpacing(
                  32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Activate sign in with biometrics',
                      style: theme.bodyLarge,
                    ),
                    //Switch detector for iOS and Android
                    ValueListenableBuilder(
                        valueListenable: _enableBiometrics,
                        builder: (context, switchState, _) {
                          return Switch.adaptive(
                              value: switchState,
                              activeColor: kPrimaryBlackColor,
                              onChanged: (value) {
                                _enableBiometrics.value = value;
                              });
                        }),
                  ],
                ),
                ColSpacing(
                  40.h,
                ),
                /*           Consumer(builder: (context, ref, _) {
                if (_editingController.text.isNotEmpty) {
                  ref.listen(setPasswordProvider(params), (_, state) {
                    state.when(
                        data: (value) => context.goNamed(kHomeOnBoardingRoute),
                        error: (error, _) =>
                            Toast.error(error.toString(), context),
                        loading: () {});
                  });
                }
                final response = ref.watch(setPasswordProvider(params));
                return response.maybeWhen(
                    orElse: () => CustomFilledButton(
                          onPressed: onSubmitted,
                          buttonText: 'Create Account',
                        ),
                    loading: () =>
                        const CircularProgressIndicator(strokeWidth: 3));
              })*/
                CustomFilledButton(
                  onPressed: onSubmitted,
                  buttonText: 'Create Account',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmitted() async {
    final FormState form = _formKey.currentState!;
    form.save();
    if (form.validate()) {
      Loader.show(context);
      final params =
          SetPasswordParams(widget.phoneNumber, _editingController.text);
      final response =
          await ref.read(userStateProvider.notifier).setUserPassword(params);
      Loader.hide();
      response.when(
          success: (_) => context.goNamed(kHomeOnBoardingRoute),
          apiFailure: (fail, _) => Toast.apiError(fail, context));
    } else {
      _autoValidate = AutovalidateMode.always;
      Toast.formError(context);
    }
  }

  void reset(FormState form) {
    form.reset();
  }

  @override
  void dispose() {
    super.dispose();
    _enableBiometrics.dispose();
    _editingController.dispose();
  }
}
