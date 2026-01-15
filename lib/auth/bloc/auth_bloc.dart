import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<VerifyOtpEvent>(_verifyOtp);
    on<SubmitProfileEvent>(_submitProfile);
  }

  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(OtpSentState());
  }

  Future<void> _verifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));

    if (event.otp == "1234") {
      emit(OtpVerifiedState());
    } else {
      emit(AuthErrorState("Invalid OTP"));
    }
  }

  Future<void> _submitProfile(
    SubmitProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 2));
    emit(ProfileCompletedState());
  }
}
