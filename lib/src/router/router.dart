import 'package:mra/app/access_control/presentation/ui/screens/access_control.dart';
import 'package:mra/app/access_control/presentation/ui/screens/resident_verification.dart';
import 'package:mra/app/alert/presentation/ui/screens/alert.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/presentation/ui/screens/create_account.dart';
import 'package:mra/app/authentication/presentation/ui/screens/otp.dart';
import 'package:mra/app/authentication/presentation/ui/screens/verify_details.dart';
import 'package:mra/app/chat/presentation/ui/screens/chat_screen.dart';
import 'package:mra/app/feedback/presentation/ui/screens/feedback.dart';
import 'package:mra/app/home/presentation/ui/screens/home.dart';
import 'package:mra/app/home/presentation/ui/screens/home_demo.dart';
import 'package:mra/app/home_settings/presentation/ui/screens/home_settings.dart';
import 'package:mra/app/notice_board/presentation/ui/screens/notice_board.dart';
import 'package:mra/app/notification/presentation/ui/screens/notification.dart';
import 'package:mra/app/onboarding/presentation/ui/screens/launch.dart';
import 'package:mra/app/onboarding/presentation/ui/screens/on_boarding.dart';
import 'package:mra/app/onboarding/presentation/ui/screens/on_boarding_complete.dart';
import 'package:mra/app/onboarding/presentation/ui/screens/rules_and_regulations.dart';
import 'package:mra/app/payments/presentation/ui/screens/invoices_view.dart';
import 'package:mra/app/payments/presentation/ui/screens/payment_verification.dart';
import 'package:mra/app/payments/presentation/ui/screens/payment_view.dart';
import 'package:mra/app/payments/presentation/ui/screens/payments.dart';
import 'package:mra/app/payments/presentation/ui/screens/transactions_view.dart';
import 'package:mra/app/profile/presentation/ui/screens/edit_profile.dart';
import 'package:mra/app/profile/presentation/ui/screens/personal.dart';
import 'package:mra/app/profile/presentation/ui/screens/profile.dart';
import 'package:mra/app/profile/presentation/ui/screens/reset_password.dart';
import 'package:mra/app/services/presentation/ui/screens/services.dart';
import 'package:mra/core/services/storage/store.dart';
import 'package:mra/src/components//not_found/not_found.dart';
import 'package:mra/src/components/app_shell/app_shell.dart';
import 'package:mra/src/router/routes.dart' as routes;
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  WidgetRef ref;

  AppRouter(this.ref);

  String? _routeRedirection(Object? argument, String path) {
    return argument == null ? path : null;
  }

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final router = GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: routes.kLaunchRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kLaunchRoute,
          pageBuilder: (_, __) => const MaterialPage(child: LaunchScreen()),
        ),
        GoRoute(
          path: '/',
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kOnBoardingRoute,
          redirect: (_, __) =>
              Store.fetchOnBoardingInfo() ? routes.kLaunchRoute.path : null,
          pageBuilder: (_, __) => const MaterialPage(child: OnBoardingScreen()),
        ),
        /*GoRoute(
          path: '/',
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kEditProfileRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: EditProfileScreen()),
        ),*/
        GoRoute(
          path: routes.kVerifyDetailsRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kVerifyDetailsRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: VerifyDetailsScreen()),
        ),
        GoRoute(
          path: routes.kCreateAccountRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kCreateAccountRoute,
          pageBuilder: (_, state) => MaterialPage(
            child: CreateAccountScreen(
              phoneNumber: state.extra as String,
            ),
          ),
        ),
/*        GoRoute(
          path: routes.kLoginRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kLoginRoute,
          pageBuilder: (_, __) => const MaterialPage(child: LoginScreen()),
        ),*/
        GoRoute(
          path: routes.kOTPRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kOTPRoute,
          pageBuilder: (_, state) => MaterialPage(
            child: OTPScreen(args: state.extra as OtpArgs),
          ),
        ),
        GoRoute(
          path: routes.kHomeOnBoardingRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kHomeOnBoardingRoute,
          pageBuilder: (_, __) => const MaterialPage(child: HomeDemoScreen()),
        ),
        GoRoute(
          path: routes.kRulesAndRegulationRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kRulesAndRegulationRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: RuleAndRegulationScreen()),
        ),
        GoRoute(
          path: routes.kOnBoardingProfileRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kOnBoardingProfileRoute,
          pageBuilder: (_, __) => const MaterialPage(child: PersonalTabView()),
        ),
        GoRoute(
          path: routes.kOnBoardingCompleteRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kOnBoardingCompleteRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: OnBoardingCompleteScreen()),
        ),
        GoRoute(
          path: routes.kHomeSettingsRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kHomeSettingsRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: HomeSettingsScreen()),
        ),
        GoRoute(
          path: routes.kServicesRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kServicesRoute,
          pageBuilder: (_, __) => const MaterialPage(child: ServicesScreen()),
        ),
        GoRoute(
          path: routes.kResetPasswordRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kResetPasswordRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: ResetPasswordScreen()),
        ),
        GoRoute(
          path: routes.kAlertRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kAlertRoute,
          pageBuilder: (_, __) => const MaterialPage(child: AlertScreen()),
        ),
        GoRoute(
          path: routes.kProfileRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kProfileRoute,
          pageBuilder: (_, __) => const MaterialPage(child: ProfileScreen()),
        ),
        GoRoute(
          path: routes.kEditProfileRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kEditProfileRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: EditProfileScreen()),
        ),
        GoRoute(
          path: routes.kNotificationRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kNotificationRoute,
          pageBuilder: (_, __) =>
              const MaterialPage(child: NotificationScreen()),
        ),
        GoRoute(
          path: routes.kFeedbackRoute.path,
          parentNavigatorKey: _rootNavigatorKey,
          name: routes.kFeedbackRoute,
          pageBuilder: (_, __) => const MaterialPage(child: FeedbackScreen()),
        ),
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return AppShell(child);
            },
            routes: [
              GoRoute(
                  path: routes.kHomeRoute.path,
                  name: routes.kHomeRoute,
                  pageBuilder: (_, __) {
                    return const MaterialPage(
                      child: Home(
                        key: ValueKey('Home'),
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: routes.kAccessControlRoute,
                      parentNavigatorKey: _rootNavigatorKey,
                      name: routes.kAccessControlRoute,
                      pageBuilder: (_, __) =>
                          const MaterialPage(child: AccessControlScreen()),
                    ),
                    GoRoute(
                      path: routes.kNoticeBoardRoute,
                      parentNavigatorKey: _rootNavigatorKey,
                      name: routes.kNoticeBoardRoute,
                      pageBuilder: (_, __) =>
                          const MaterialPage(child: NoticeBoardScreen()),
                    ),
                    GoRoute(
                      path: routes.kResidentVerificationRoute,
                      parentNavigatorKey: _rootNavigatorKey,
                      name: routes.kResidentVerificationRoute,
                      pageBuilder: (_, __) =>
                          const MaterialPage(child: ResidentVerification()),
                    ),
                  ]),
              GoRoute(
                  path: routes.kPaymentsRoute.path,
                  name: routes.kPaymentsRoute,
                  pageBuilder: (_, __) {
                    return const MaterialPage(
                      child: Payments(
                        key: ValueKey('Payments'),
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: routes.kPaymentViewRoute,
                      name: routes.kPaymentViewRoute,
                      parentNavigatorKey: _rootNavigatorKey,
                      redirect: (_, state) =>
                          _routeRedirection(state.extra, kPaymentsRoute.path),
                      pageBuilder: (_, state) {
                        final info = state.extra as PaymentViewInfo;
                        return MaterialPage(
                          child: PaymentView(
                            key: const ValueKey('PaymentView'),
                            intent: info.intent,
                            invoice: info.invoice,
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: routes.kPaymentVerificationRoute,
                      parentNavigatorKey: _rootNavigatorKey,
                      redirect: (_, state) =>
                          _routeRedirection(state.extra, kPaymentsRoute.path),
                      name: routes.kPaymentVerificationRoute,
                      pageBuilder: (_, state) => MaterialPage(
                          child: PaymentVerification(
                              state.extra as PaymentViewInfo)),
                    ),
                    GoRoute(
                      path: routes.kInvoicesViewRoute,
                      name: routes.kInvoicesViewRoute,
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (_, __) {
                        return const MaterialPage(
                          child: InvoicesView(
                            key: ValueKey('InvoiceView'),
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: routes.kTransactionsViewRoute,
                      name: routes.kTransactionsViewRoute,
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (_, __) {
                        return const MaterialPage(
                          child: TransactionsView(
                            key: ValueKey('TransactionView'),
                          ),
                        );
                      },
                    ),
                  ]),
              GoRoute(
                path: routes.kChatRoute.path,
                name: routes.kChatRoute,
                pageBuilder: (_, __) {
                  return const MaterialPage(
                    child: ChatScreen(
                      key: ValueKey('Chat'),
                    ),
                  );
                },
              ),
            ])
      ],
      redirect: (context, state) {
        final user = ref.read(userStateProvider);
        final loggedIn = user != null;
        bool isLoggingOut = ref.read(sessionProvider).accessToken == null;
        bool isOpenRoute = openRoutes.contains(state.matchedLocation);
        String? redirectedRoute;
        if (loggedIn && isOpenRoute && !isLoggingOut) {
          redirectedRoute = routes.kHomeRoute.path;
        } else if ((!loggedIn || isLoggingOut) && !isOpenRoute) {
          redirectedRoute = kLaunchRoute.path;
        }
        return state.matchedLocation == redirectedRoute
            ? null
            : redirectedRoute;
      },
      redirectLimit: 5,
      debugLogDiagnostics: true,
      refreshListenable: ref.read(sessionProvider),
      // test mode
      errorPageBuilder: (context, state) {
        return const MaterialPage(
          child: NotFoundPage(),
        );
      });

  final List<String> openRoutes = [
    routes.kLaunchRoute.path,
    "/",
    routes.kVerifyDetailsRoute.path,
    routes.kCreateAccountRoute.path,
    routes.kOTPRoute.path
  ];
}
