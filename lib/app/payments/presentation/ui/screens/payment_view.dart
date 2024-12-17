import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/data/models/payment_intent.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

const redirectUrl = "https://deamsoft.com/";
class PaymentView extends StatefulWidget {
  final PaymentIntent intent;
  final Invoice invoice;
  const PaymentView({Key? key, required this.intent, required this.invoice})
      : super(key: key);

  @override
  PaymentViewState createState() => PaymentViewState();
}

class PaymentViewState extends State<PaymentView> {
  final ValueNotifier<bool> _loader = ValueNotifier<bool>(true);
  late WebViewController _controller;

  @override
  void initState() {
    // if (UniversalPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('FlutterResult',
          onMessageReceived: (JavaScriptMessage message) {
        if (message.message == "OnClose") {
          Navigator.of(context).pop(); //close webview
        }
      })
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {},
            onUrlChange: (url) {},
            onPageStarted: (String url) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.contains(redirectUrl)) {
                context.goNamed(
                  kPaymentVerificationRoute,
                  extra: PaymentViewInfo(widget.intent, widget.invoice),
                );
                return NavigationDecision.prevent;
              }
              if (request.url == 'https://standard.paystack.co/close') {
                Navigator.of(context).pop(); //close webview
              }
              if (request.url == "https://hello.pstk.xyz/callback") {
                Navigator.of(context).pop(); //close webview
              }

              return NavigationDecision.navigate;
            },
            onWebResourceError: (error) {
              if (error.isForMainFrame ?? false) {
                Navigator.pop(context);
                 ErrorState.showModal(context);
              }
            },
            onPageFinished: (_) {
              if (mounted) _loader.value = false;
              _controller.runJavaScript('''
                 window.addEventListener("beforeunload", function (e) {
                     console.log("onBeforeLoad");
                     FlutterResult.postMessage("OnClose");       
                  });
                  console.log("registered event handler:onBeforeLoad");
              ''');
            }),
      )
      //   ..setBackgroundColor(kColorWhite)
      ..loadRequest(
        Uri.parse(widget.intent.authorizationUrl),
      );
    super.initState();
  }

  Widget _buildLoader() {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxHeight: 2.0, minWidth: double.infinity),
      child: const LinearProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              ValueListenableBuilder(
                valueListenable: _loader,
                builder: (context, dynamic loading, child) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: loading ? child : const SizedBox.shrink(),
                  );
                },
                child: _buildLoader(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentViewInfo {
  final PaymentIntent intent;
  final Invoice invoice;

  PaymentViewInfo(this.intent, this.invoice);
}
