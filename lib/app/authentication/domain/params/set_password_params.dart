import 'package:equatable/equatable.dart';

class SetPasswordParams extends Equatable {
  final String phoneNumber;
  final String password;

  const SetPasswordParams(this.phoneNumber, this.password);

  toJson() => {"phoneNumber": phoneNumber, "password": password};

  @override
  List<Object?> get props => [phoneNumber, password];
}
