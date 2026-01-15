// auth_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSentState extends AuthState {}

class OtpVerifiedState extends AuthState {}

class ProfileCompletedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
}
