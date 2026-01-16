part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final Transaction transaction;

  const TransactionSuccess({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class TransactionLoaded extends TransactionState {
  final Transaction transaction;

  const TransactionLoaded({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class TransactionHistoryLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionHistoryLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}
