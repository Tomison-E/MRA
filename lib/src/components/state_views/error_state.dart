import 'package:mra/core/service_exceptions/service_exception.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:mra/src/utils/error_mapper/error_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ErrorState extends StatelessWidget{
  ErrorState(
      {Key? key,
      this.errorDetails,
      this.message,
      this.retryAction,
      this.userError = true,
      this.error})
      : super(key: key) {
/*    if (errorDetails != null) {
      ErrorHandler.report(
        errorDetails!.exception,
        errorDetails!.stack,
        hint: {
          'context': errorDetails!.context,
          'summary': errorDetails!.summary.toString(),
          'library': errorDetails!.library,
        },
      );
    }*/
  }

  static Future<void> showModal(BuildContext context,
      {FlutterErrorDetails? errorDetails}) async {
    return await showModalBottomSheet<void>(
      context: context,
      builder: (_) => ErrorState(errorDetails: errorDetails, userError: false),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.white,
    );
  }

  final FlutterErrorDetails? errorDetails;
  final VoidCallback? retryAction;
  final bool userError;
  final String? message;
  final Object? error;

  String? errorInfo() {
    if (message?.isEmpty ?? true && error != null) {
      if (error is ApiExceptions) {
        return ApiExceptions.getErrorMessage(error as ApiExceptions);
      } else {
        return error.toString();
      }
    } else {
      return message;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final info = errorInfo();
    final actionButton = retryAction == null
        ? FilledButton(
            child: const Text('Dismiss'),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                context.goNamed(kHomeRoute);
              }
            },
          )
        : FilledButton(
            onPressed: retryAction,
            child: const Text('Retry'),
          );
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!userError || (info?.isEmpty ?? true) || ErrorMapper.isServiceDefinedError(info!)) ...[
                SvgPicture.asset(kLogoSvg),
                const ColSpacing(16),
                Text(
                  'Oops! Something went wrong',
                  style: textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const ColSpacing(16),
                Text(
                  'Don’t worry, we are in the process of fixing the issue. Please contact support if you need immediate help or give us a little time to work things out.',
                  style: textTheme.bodyLarge?.copyWith(color: kHelperTextColor),
                  textAlign: TextAlign.center,
                ),
                const ColSpacing(16),
                Text(
                  'Thank you for your patience.',
                  style: textTheme.bodyLarge?.copyWith(
                    color: kTextBodyColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const ColSpacing(16),
                actionButton
              ] else ...[
                Text(
                  'Error',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  info,
                  textAlign: TextAlign.center,
                ),
                const ColSpacing(16),
                actionButton
              ]
            ],
          ),
        ),
    );
  }
}
