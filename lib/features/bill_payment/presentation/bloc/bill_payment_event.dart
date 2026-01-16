part of 'bill_payment_bloc.dart';

abstract class BillPaymentEvent extends Equatable {
  const BillPaymentEvent();

  @override
  List<Object> get props => [];
}

class PayBillEvent extends BillPaymentEvent {
  final String userId;
  final BillType billType;
  final BillProvider provider;
  final String accountNumber;
  final double amount;
  final String pin;

  const PayBillEvent({
    required this.userId,
    required this.billType,
    required this.provider,
    required this.accountNumber,
    required this.amount,
    required this.pin,
  });

  @override
  List<Object> get props => [userId, billType, provider, accountNumber, amount, pin];
}

class GetBillPaymentHistoryEvent extends BillPaymentEvent {
  final String userId;

  const GetBillPaymentHistoryEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
