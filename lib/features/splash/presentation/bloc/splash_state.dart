part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashAuthenticated extends SplashState {
  final User user;

  const SplashAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}
