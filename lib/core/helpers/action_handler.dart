import 'package:mra/core/service_result/service_result.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';

typedef ActionCall = Future<ApiResult> Function();
typedef OnSuccessCall = VoidCallback;

Future<void> actionHandler(
    BuildContext context, ActionCall action, OnSuccessCall onSuccess) async {
  Loader.show(context);
  final response = await action();
  Loader.hide();
  response.when(
    success: (_) => onSuccess(),
    apiFailure: (error, __) => Toast.apiError(error, context),
  );
}
