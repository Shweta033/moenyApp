part of 'airtime_bloc.dart';

abstract class AirtimeEvent extends Equatable {
  const AirtimeEvent();

  @override
  List<Object> get props => [];
}

class PurchaseAirtimeEvent extends AirtimeEvent {
  final String userId;
  final AirtimeProvider provider;
  final String mobileNumber;
  final double amount;
  final String pin;

  const PurchaseAirtimeEvent({
    required this.userId,
    required this.provider,
    required this.mobileNumber,
    required this.amount,
    required this.pin,
  });

  @override
  List<Object> get props => [userId, provider, mobileNumber, amount, pin];
}

class GetAirtimePurchaseHistoryEvent extends AirtimeEvent {
  final String userId;

  const GetAirtimePurchaseHistoryEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
