import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/pay_bill.dart';
import '../../domain/usecases/get_bill_payment_history.dart';
import '../../domain/entities/bill_payment.dart';
import '../../../../core/error/failures.dart';

part 'bill_payment_event.dart';
part 'bill_payment_state.dart';

class BillPaymentBloc extends Bloc<BillPaymentEvent, BillPaymentState> {
  final PayBill payBill;
  final GetBillPaymentHistory getBillPaymentHistory;

  BillPaymentBloc({
    required this.payBill,
    required this.getBillPaymentHistory,
  }) : super(BillPaymentInitial()) {
    on<PayBillEvent>(_onPayBill);
    on<GetBillPaymentHistoryEvent>(_onGetBillPaymentHistory);
  }

  Future<void> _onPayBill(
    PayBillEvent event,
    Emitter<BillPaymentState> emit,
  ) async {
    emit(BillPaymentLoading());
    final result = await payBill(PayBillParams(
      userId: event.userId,
      billType: event.billType,
      provider: event.provider,
      accountNumber: event.accountNumber,
      amount: event.amount,
      pin: event.pin,
    ));
    result.fold(
      (failure) => emit(BillPaymentError(_mapFailureToMessage(failure))),
      (billPayment) => emit(BillPaymentSuccess(billPayment: billPayment)),
    );
  }

  Future<void> _onGetBillPaymentHistory(
    GetBillPaymentHistoryEvent event,
    Emitter<BillPaymentState> emit,
  ) async {
    emit(BillPaymentLoading());
    final result = await getBillPaymentHistory(GetBillPaymentHistoryParams(
      userId: event.userId,
    ));
    result.fold(
      (failure) => emit(BillPaymentError(_mapFailureToMessage(failure))),
      (billPayments) => emit(BillPaymentHistoryLoaded(billPayments: billPayments)),
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
