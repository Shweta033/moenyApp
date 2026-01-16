part of 'bill_payment_bloc.dart';

abstract class BillPaymentState extends Equatable {
  const BillPaymentState();

  @override
  List<Object> get props => [];
}

class BillPaymentInitial extends BillPaymentState {}

class BillPaymentLoading extends BillPaymentState {}

class BillPaymentSuccess extends BillPaymentState {
  final BillPayment billPayment;

  const BillPaymentSuccess({required this.billPayment});

  @override
  List<Object> get props => [billPayment];
}

class BillPaymentHistoryLoaded extends BillPaymentState {
  final List<BillPayment> billPayments;

  const BillPaymentHistoryLoaded({required this.billPayments});

  @override
  List<Object> get props => [billPayments];
}

class BillPaymentError extends BillPaymentState {
  final String message;

  const BillPaymentError(this.message);

  @override
  List<Object> get props => [message];
}
