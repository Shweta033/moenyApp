part of 'airtime_bloc.dart';

abstract class AirtimeState extends Equatable {
  const AirtimeState();

  @override
  List<Object> get props => [];
}

class AirtimeInitial extends AirtimeState {}

class AirtimeLoading extends AirtimeState {}

class AirtimePurchaseSuccess extends AirtimeState {
  final AirtimePurchase airtimePurchase;

  const AirtimePurchaseSuccess({required this.airtimePurchase});

  @override
  List<Object> get props => [airtimePurchase];
}

class AirtimePurchaseHistoryLoaded extends AirtimeState {
  final List<AirtimePurchase> airtimePurchases;

  const AirtimePurchaseHistoryLoaded({required this.airtimePurchases});

  @override
  List<Object> get props => [airtimePurchases];
}

class AirtimeError extends AirtimeState {
  final String message;

  const AirtimeError(this.message);

  @override
  List<Object> get props => [message];
}
