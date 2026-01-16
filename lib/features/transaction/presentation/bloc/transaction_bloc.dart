import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/send_money.dart';
import '../../domain/usecases/request_money.dart';
import '../../domain/usecases/get_transaction_history.dart';
import '../../domain/usecases/get_transaction_by_id.dart';
import '../../domain/entities/transaction.dart';
import '../../../../core/error/failures.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final SendMoney sendMoney;
  final RequestMoney requestMoney;
  final GetTransactionHistory getTransactionHistory;
  final GetTransactionById getTransactionById;

  TransactionBloc({
    required this.sendMoney,
    required this.requestMoney,
    required this.getTransactionHistory,
    required this.getTransactionById,
  }) : super(TransactionInitial()) {
    on<SendMoneyEvent>(_onSendMoney);
    on<RequestMoneyEvent>(_onRequestMoney);
    on<GetTransactionHistoryEvent>(_onGetTransactionHistory);
    on<GetTransactionByIdEvent>(_onGetTransactionById);
  }

  Future<void> _onSendMoney(
    SendMoneyEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    final result = await sendMoney(SendMoneyParams(
      userId: event.userId,
      recipientMobileNumber: event.recipientMobileNumber,
      amount: event.amount,
      pin: event.pin,
    ));
    result.fold(
      (failure) => emit(TransactionError(_mapFailureToMessage(failure))),
      (transaction) => emit(TransactionSuccess(transaction: transaction)),
    );
  }

  Future<void> _onRequestMoney(
    RequestMoneyEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    final result = await requestMoney(RequestMoneyParams(
      userId: event.userId,
      requesterMobileNumber: event.requesterMobileNumber,
      amount: event.amount,
    ));
    result.fold(
      (failure) => emit(TransactionError(_mapFailureToMessage(failure))),
      (transaction) => emit(TransactionSuccess(transaction: transaction)),
    );
  }

  Future<void> _onGetTransactionHistory(
    GetTransactionHistoryEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    final result = await getTransactionHistory(GetTransactionHistoryParams(
      userId: event.userId,
      limit: event.limit,
      offset: event.offset,
    ));
    result.fold(
      (failure) => emit(TransactionError(_mapFailureToMessage(failure))),
      (transactions) => emit(TransactionHistoryLoaded(transactions: transactions)),
    );
  }

  Future<void> _onGetTransactionById(
    GetTransactionByIdEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    final result = await getTransactionById(GetTransactionByIdParams(
      transactionId: event.transactionId,
    ));
    result.fold(
      (failure) => emit(TransactionError(_mapFailureToMessage(failure))),
      (transaction) => emit(TransactionLoaded(transaction: transaction)),
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
