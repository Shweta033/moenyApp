import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final String id;
  final String userId;
  final String provider; // MTN, Vodafone, AirtelTigo
  final double balance;
  final String currency;
  final DateTime lastUpdated;

  const Wallet({
    required this.id,
    required this.userId,
    required this.provider,
    required this.balance,
    this.currency = 'GHS',
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [id, userId, provider, balance, currency, lastUpdated];
}
