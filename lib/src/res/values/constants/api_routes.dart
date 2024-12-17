const String kUserRoute = "/v1/user";
const String kHouseHoldRoute = "/v1/household";
const String kGuestRoute = "/v1/guest";
const String kEstateRoute = "/v1/estate";
const String kAnnouncementRoute = "/v1/announcements";
const String kAlertsRoute = "/v1/alert";
const String kChatRoute = "/v1/chat";
const String kChatsRoute = "/v1/chats";
const String kInvoiceRoute = "/v1/invoice";
const String kInvoiceTransactionRoute = "/v1/invoice-transaction";
const String kPaymentRoute = "/v1/payment";


///
const kSendOtpApi = "/send-otp";
const kVerifyOtpApi = "/verify-otp";
const kGetLoggedInUserApi = "$kUserRoute/me";
const kSetPasswordApi = "$kUserRoute/password";
const kLoginApi = "/login";
const kTermsApi = "$kUserRoute/terms";
const kUploadApi = "$kUserRoute/upload";

///
const String kPersonnelRoute = "$kHouseHoldRoute/personnel";

/// GUEST ROUTE
const String kGuestHistoryRoute = "$kGuestRoute/history";
const String kGuestUpdateRoute = "$kGuestRoute/status";


///ALERT ROUTE
const kAlertReportApi = "$kAlertsRoute/report";
const kAlertReportsApi = "$kAlertsRoute/reports";

/// [PAYMENT ROUTE]
const kPaymentInitApi = "$kPaymentRoute/init";
const kPaymentVerifyApi = "$kPaymentRoute/verify-payment";