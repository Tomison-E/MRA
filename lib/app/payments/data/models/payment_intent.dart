class PaymentIntent {
  final String reference;
  final String authorizationUrl;
  final String accessCode;

  factory PaymentIntent.fromMap(Map<String, dynamic> data) {
    return PaymentIntent(
        data["reference"], data["authorization_url"], data['access_code']);
  }

  PaymentIntent(this.reference, this.authorizationUrl,this.accessCode);
}

