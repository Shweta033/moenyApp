// auth_event.dart
abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String mobile;
  SendOtpEvent(this.mobile);
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  VerifyOtpEvent(this.otp);
}

class SubmitProfileEvent extends AuthEvent {
  final String name;
  final String idNumber;
  SubmitProfileEvent(this.name, this.idNumber);
}
