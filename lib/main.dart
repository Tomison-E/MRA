import 'package:mra/core/services/storage/store.dart';
import 'package:mra/mra_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mra/src/res/styles/colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Store.init();
  final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: kPrimaryColor.withOpacity(0.05),
      statusBarColor: kPrimaryColor.withOpacity(0.05));
  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: MraApp()));
  /*FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };*/
}
