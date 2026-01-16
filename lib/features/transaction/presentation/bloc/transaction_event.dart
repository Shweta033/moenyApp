part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class SendMoneyEvent extends TransactionEvent {
  final String userId;
  final String recipientMobileNumber;
  final double amount;
  final String pin;

  const SendMoneyEvent({
    required this.userId,
    required this.recipientMobileNumber,
    required this.amount,
    required this.pin,
  });

  @override
  List<Object> get props => [userId, recipientMobileNumber, amount, pin];
}

class RequestMoneyEvent extends TransactionEvent {
  final String userId;
  final String requesterMobileNumber;
  final double amount;

  const RequestMoneyEvent({
    required this.userId,
    required this.requesterMobileNumber,
    required this.amount,
  });

  @override
  List<Object> get props => [userId, requesterMobileNumber, amount];
}

class GetTransactionHistoryEvent extends TransactionEvent {
  final String userId;
  final int? limit;
  final int? offset;

  const GetTransactionHistoryEvent({
    required this.userId,
    this.limit,
    this.offset,
  });

  @override
  List<Object> get props => [userId];
}

class GetTransactionByIdEvent extends TransactionEvent {
  final String transactionId;

  const GetTransactionByIdEvent({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}
