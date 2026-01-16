part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class GetWalletEvent extends WalletEvent {
  final String userId;
  final String provider;

  const GetWalletEvent({
    required this.userId,
    required this.provider,
  });

  @override
  List<Object> get props => [userId, provider];
}

class GetUserWalletsEvent extends WalletEvent {
  final String userId;

  const GetUserWalletsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class RefreshWalletBalanceEvent extends WalletEvent {
  final String walletId;

  const RefreshWalletBalanceEvent({required this.walletId});

  @override
  List<Object> get props => [walletId];
}
