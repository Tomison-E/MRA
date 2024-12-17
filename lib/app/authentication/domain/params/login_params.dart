class LoginParams {
  String phoneNumber;
  String authToken;

  LoginParams({required this.authToken,required this.phoneNumber});

  set phone(String number) => phoneNumber = number;
  set token(String token) => authToken = token;

  toJson() => {"phoneNumber": phoneNumber, "authToken": authToken};
}
