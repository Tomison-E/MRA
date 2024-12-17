import 'package:mra/core/service_exceptions/service_exception.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/utils/error_mapper/error_mapper.dart';
import 'package:flutter/material.dart';

class Toast {
  static const double _toastHeight = 70.0;
  static const Color _backgroundColor = Color.fromRGBO(247, 247, 247, 1);

  static void show(
    String? msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(
      context,
      title ?? 'Success',
      msg ?? '',
      Icons.check_circle_outline,
      const Color(0xFF25D366),
      duration,
    );
  }

  static void success(
    String? msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(
      context,
      title ?? 'Success',
      msg ?? '',
      Icons.check_circle_outline,
      const Color(0xFF25D366),
      duration,
    );
  }

  static void error(
    String msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    ErrorMapper.isServiceDefinedError(msg)
        ? ErrorState.showModal(context)
        : _showToast(
            context,
            title ?? 'Error',
            msg,
            Icons.error_outline,
            const Color(0xFFEB0000),
            duration,
          );
  }

  static void exception(
    Object errors,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    error(errors.toString(), context, title: title, duration: duration);
  }

  static void formError(
    BuildContext context, {
    int duration = 5,
  }) {
    _showToast(
      context,
      "Error",
      "Fix highlighted errors",
      Icons.error_outline,
      const Color(0xFFEB0000),
      duration,
    );
  }

  static void apiError(
    ApiExceptions exception,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    error(
      ApiExceptions.getErrorMessage(exception),
      context,
      title: title,
      duration: duration,
    );
  }

  static void info(
    String? msg,
    BuildContext context, {
    String? title,
    int duration = 5,
  }) {
    _showToast(context, title ?? 'Info', msg ?? '', Icons.warning_outlined,
        const Color(0xFFF59300), duration);
  }

  static void _showToast(
    BuildContext context,
    String title,
    String body,
    IconData icon,
    Color iconColor,
    int seconds,
  ) {
    final overlayState = Overlay.of(context);
    final textTheme = Theme.of(context).textTheme;
    final duration = Duration(seconds: seconds);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            if (overlayEntry.mounted) {
              overlayEntry.remove();
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: _toastHeight,
              color: _backgroundColor,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 32.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: textTheme.labelMedium?.copyWith(
                            color: iconColor,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(body, style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(duration).then((_) {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
