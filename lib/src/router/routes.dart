const kOnBoardingRoute = "onBoarding";
const kLaunchRoute = "launch";
const kVerifyDetailsRoute = 'verifyDetails';
const kCreateAccountRoute = 'createAccount';
//const kLoginRoute = 'login';
const kOTPRoute = 'otp';
const kHomeOnBoardingRoute = 'homeOnBoarding';
const kRulesAndRegulationRoute = 'signRulesAndRegulation';
const kOnBoardingProfileRoute = 'onBoardingProfile';
const kOnBoardingCompleteRoute = 'onBoardingComplete';
const kHomeRoute = 'home';
const kPaymentsRoute = 'payments';
const kChatRoute = 'chat';
const kNoticeBoardRoute = 'noticeBoard';
const kAccessControlRoute = 'accessControl';
const kHomeSettingsRoute = 'homeSettings';
const kServicesRoute = 'services';
const kAlertRoute = 'alert';
const kEditProfileRoute = 'editProfile';
const kProfileRoute = 'profile';
const kResetPasswordRoute = 'resetPassword';
const kNotificationRoute = 'notification';
const kFeedbackRoute = 'feedback';
const kResidentVerificationRoute = 'residentVerification';
const kPaymentVerificationRoute = 'paymentVerification';
const kPaymentViewRoute = 'paymentView';
const kInvoicesViewRoute = 'upcomingView';
const kTransactionsViewRoute = 'transactionView';

extension RoutePaths on String {
  String get path => "/$this";
}
