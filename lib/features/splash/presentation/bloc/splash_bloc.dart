import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../auth/domain/usecases/get_current_user.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../../core/usecase/usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCurrentUser getCurrentUser;

  SplashBloc({
    required this.getCurrentUser,
  }) : super(SplashInitial()) {
    on<StartSplashEvent>(_onStartSplash);
  }

  Future<void> _onStartSplash(
    StartSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    
    final result = await getCurrentUser(const NoParams());
    
    result.fold(
      (_) => emit(const SplashUnauthenticated()),
      (user) {
        if (user != null) {
          emit(SplashAuthenticated(user: user));
        } else {
          emit(const SplashUnauthenticated());
        }
      },
    );
  }
}
