part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String mobileNumber;

  const SendOtpEvent(this.mobileNumber);

  @override
  List<Object> get props => [mobileNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String mobileNumber;
  final String otp;

  const VerifyOtpEvent({
    required this.mobileNumber,
    required this.otp,
  });

  @override
  List<Object> get props => [mobileNumber, otp];
}

class SubmitProfileEvent extends AuthEvent {
  final String userId;
  final String name;
  final String idNumber;

  const SubmitProfileEvent({
    required this.userId,
    required this.name,
    required this.idNumber,
  });

  @override
  List<Object> get props => [userId, name, idNumber];
}

class GetCurrentUserEvent extends AuthEvent {
  const GetCurrentUserEvent();
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
