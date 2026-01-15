import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilemoney/splah/bloc/splah_state.dart';
import 'package:mobilemoney/splah/bloc/splash_event.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplashEvent>(_onStart);
  }

  Future<void> _onStart(
    StartSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 5));

    // TODO: Replace with real login check
    bool isLoggedIn = false;

    if (isLoggedIn) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
