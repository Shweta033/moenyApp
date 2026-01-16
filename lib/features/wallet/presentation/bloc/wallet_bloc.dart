import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_wallet.dart';
import '../../domain/usecases/get_user_wallets.dart';
import '../../domain/usecases/refresh_wallet_balance.dart';
import '../../domain/entities/wallet.dart';
import '../../../../core/error/failures.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWallet getWallet;
  final GetUserWallets getUserWallets;
  final RefreshWalletBalance refreshWalletBalance;

  WalletBloc({
    required this.getWallet,
    required this.getUserWallets,
    required this.refreshWalletBalance,
  }) : super(WalletInitial()) {
    on<GetWalletEvent>(_onGetWallet);
    on<GetUserWalletsEvent>(_onGetUserWallets);
    on<RefreshWalletBalanceEvent>(_onRefreshWalletBalance);
  }

  Future<void> _onGetWallet(
    GetWalletEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    final result = await getWallet(GetWalletParams(
      userId: event.userId,
      provider: event.provider,
    ));
    result.fold(
      (failure) => emit(WalletError(_mapFailureToMessage(failure))),
      (wallet) => emit(WalletLoaded(wallet: wallet)),
    );
  }

  Future<void> _onGetUserWallets(
    GetUserWalletsEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    final result = await getUserWallets(GetUserWalletsParams(userId: event.userId));
    result.fold(
      (failure) => emit(WalletError(_mapFailureToMessage(failure))),
      (wallets) => emit(WalletsLoaded(wallets: wallets)),
    );
  }

  Future<void> _onRefreshWalletBalance(
    RefreshWalletBalanceEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    final result = await refreshWalletBalance(RefreshWalletBalanceParams(
      walletId: event.walletId,
    ));
    result.fold(
      (failure) => emit(WalletError(_mapFailureToMessage(failure))),
      (wallet) => emit(WalletLoaded(wallet: wallet)),
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
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
