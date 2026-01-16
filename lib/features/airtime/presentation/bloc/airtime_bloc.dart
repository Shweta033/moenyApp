import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/purchase_airtime.dart';
import '../../domain/usecases/get_airtime_purchase_history.dart';
import '../../domain/entities/airtime_purchase.dart';
import '../../../../core/error/failures.dart';

part 'airtime_event.dart';
part 'airtime_state.dart';

class AirtimeBloc extends Bloc<AirtimeEvent, AirtimeState> {
  final PurchaseAirtime purchaseAirtime;
  final GetAirtimePurchaseHistory getAirtimePurchaseHistory;

  AirtimeBloc({
    required this.purchaseAirtime,
    required this.getAirtimePurchaseHistory,
  }) : super(AirtimeInitial()) {
    on<PurchaseAirtimeEvent>(_onPurchaseAirtime);
    on<GetAirtimePurchaseHistoryEvent>(_onGetAirtimePurchaseHistory);
  }

  Future<void> _onPurchaseAirtime(
    PurchaseAirtimeEvent event,
    Emitter<AirtimeState> emit,
  ) async {
    emit(AirtimeLoading());
    final result = await purchaseAirtime(PurchaseAirtimeParams(
      userId: event.userId,
      provider: event.provider,
      mobileNumber: event.mobileNumber,
      amount: event.amount,
      pin: event.pin,
    ));
    result.fold(
      (failure) => emit(AirtimeError(_mapFailureToMessage(failure))),
      (airtimePurchase) => emit(AirtimePurchaseSuccess(airtimePurchase: airtimePurchase)),
    );
  }

  Future<void> _onGetAirtimePurchaseHistory(
    GetAirtimePurchaseHistoryEvent event,
    Emitter<AirtimeState> emit,
  ) async {
    emit(AirtimeLoading());
    final result = await getAirtimePurchaseHistory(GetAirtimePurchaseHistoryParams(
      userId: event.userId,
    ));
    result.fold(
      (failure) => emit(AirtimeError(_mapFailureToMessage(failure))),
      (airtimePurchases) => emit(AirtimePurchaseHistoryLoaded(airtimePurchases: airtimePurchases)),
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
