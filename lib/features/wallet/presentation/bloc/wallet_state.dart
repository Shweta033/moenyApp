part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final Wallet wallet;

  const WalletLoaded({required this.wallet});

  @override
  List<Object> get props => [wallet];
}

class WalletsLoaded extends WalletState {
  final List<Wallet> wallets;

  const WalletsLoaded({required this.wallets});

  @override
  List<Object> get props => [wallets];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object> get props => [message];
}
