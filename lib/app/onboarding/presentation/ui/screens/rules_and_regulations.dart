import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/core/helpers/action_handler.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class RuleAndRegulationScreen extends ConsumerStatefulWidget {
  const RuleAndRegulationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RulesAndRegulationScreen();
  }
}

class _RulesAndRegulationScreen extends ConsumerState<RuleAndRegulationScreen> {
  final ValueNotifier<AsyncValue<String>> _termsNotifier =
      ValueNotifier(const AsyncLoading());

  @override
  void initState() {
    fetchRules();
    super.initState();
  }

  @override
  void dispose() {
    _termsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56.w,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: SvgPicture.asset(
              kBackIconSvg,
            ),
          ),
        ),
        title: const Text('Rules and regulations'),
        backgroundColor: kScaffoldBgColor,
      ),
      backgroundColor: kScaffoldBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: Column(
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    thickness: 3,
                    child: SizedBox.expand(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ValueListenableBuilder<AsyncValue<String>>(
                          valueListenable: _termsNotifier,
                          builder: (context, terms, loader) {
                            return terms.when(
                                data: (data) => Text(
                                      data.isEmpty ? _trashText : data,
                                      style: theme.bodyLarge,
                                      textAlign: TextAlign.justify,
                                    ),
                                error: (error, __) => ErrorState(error:error),
                                loading: () => loader!);
                          },
                          child: const LinearProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Text(
                'By clicking accept you are agreeing to signing the estate rule and regulations',
                style: theme.bodyLarge?.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            ),
            CustomFilledButton(
              onPressed: accept,
              buttonText: 'Accept',
            )
          ],
        ),
      ),
    );
  }

  void fetchRules() async {
    final response = await ref.read(fetchRulesUseCaseProvider);
    response.when(
      success: (terms) => _termsNotifier.value = AsyncData(terms),
      apiFailure: (_, __) =>
          _termsNotifier.value = AsyncError(_, StackTrace.current),
    );
  }

  void accept() {
    actionHandler(
        context, () => ref.read(userStateProvider.notifier).acceptTerms(), () {
      Toast.success("Rules and regulations have been accepted", context);
   /*   if (ref.read(userStateProvider)!.todoComplete) {
        context
          ..pop()
          ..pop();
        context.pushNamed(kOnBoardingCompleteRoute);
      }*/
      context.pop();
    });
  }
}

//REMOVE THIS LATET
const String _trashText = '1.   Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    '\n2.   Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    '\n3.   Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    '\n4.   Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    '\n5.   Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odioLorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis '
    'non diam facilisi nibh odio '
    'Lorem ipsum dolor sit amet consectetur.'
    ' Mauris aliquet tellus eros sagittis non '
    'diam facilisi nibh odio Lorem ipsum dolor'
    ' sit amet consectetur. Mauris aliquet tellus '
    'eros sagittis non diam facilisi nibh odio'
    ' Lorem ipsum dolor sit amet consectetur. '
    'Mauris aliquet tellus eros sagittis non'
    ' diam facilisi nibh odio';
