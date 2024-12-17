import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/src/res/themes/theme.dart';
import 'package:mra/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class MraApp extends ConsumerStatefulWidget {
  const MraApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MraApp();
  }
}

class _MraApp extends ConsumerState<MraApp> {
  late final AppRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouter(ref);
    initOnesignal();
    super.initState();
  }

  initOnesignal() {
    //Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(ref.read(appConfigProvider).oneSignalId);

   //   The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    //  OneSignal.Notifications.requestPermission(true);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (context, child) {
            return MaterialApp.router(
              title: 'Mra',
              theme: mraDefaultTheme(context),
              routerConfig: appRouter.router,
            );
          },
        ),
      ),
    );
  }
}
