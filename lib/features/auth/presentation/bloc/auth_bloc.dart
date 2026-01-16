import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../domain/usecases/submit_profile.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOTP sendOTP;
  final VerifyOTP verifyOTP;
  final SubmitProfile submitProfile;
  final GetCurrentUser getCurrentUser;
  final Logout logout;

  AuthBloc({
    required this.sendOTP,
    required this.verifyOTP,
    required this.submitProfile,
    required this.getCurrentUser,
    required this.logout,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<SubmitProfileEvent>(_onSubmitProfile);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onSendOtp(
    SendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await sendOTP(SendOTPParams(mobileNumber: event.mobileNumber));
    result.fold(
      (failure) => emit(AuthErrorState(_mapFailureToMessage(failure))),
      (_) => emit(OtpSentState()),
    );
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await verifyOTP(VerifyOTPParams(
      mobileNumber: event.mobileNumber,
      otp: event.otp,
    ));
    result.fold(
      (failure) => emit(AuthErrorState(_mapFailureToMessage(failure))),
      (user) => emit(OtpVerifiedState(user: user)),
    );
  }

  Future<void> _onSubmitProfile(
    SubmitProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await submitProfile(SubmitProfileParams(
      userId: event.userId,
      name: event.name,
      idNumber: event.idNumber,
    ));
    result.fold(
      (failure) => emit(AuthErrorState(_mapFailureToMessage(failure))),
      (user) => emit(ProfileCompletedState(user: user)),
    );
  }

  Future<void> _onGetCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await getCurrentUser(const NoParams());
    result.fold(
      (failure) => emit(AuthErrorState(_mapFailureToMessage(failure))),
      (user) {
        if (user != null) {
          emit(AuthenticatedState(user: user));
        } else {
          emit(UnauthenticatedState());
        }
      },
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await logout(const NoParams());
    result.fold(
      (failure) => emit(AuthErrorState(_mapFailureToMessage(failure))),
      (_) => emit(UnauthenticatedState()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error. Please try again later.';
      case NetworkFailure:
        return 'No internet connection. Please check your network.';
      case CacheFailure:
        return 'Cache error. Please try again.';
      case AuthenticationFailure:
        return failure.message;
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
