import 'package:equatable/equatable.dart';

enum TransactionType {
  send,
  receive,
  request,
  billPayment,
  airtimePurchase,
}

enum TransactionStatus {
  pending,
  success,
  failed,
  cancelled,
}

class Transaction extends Equatable {
  final String id;
  final String userId;
  final TransactionType type;
  final TransactionStatus status;
  final double amount;
  final String currency;
  final String? recipientMobileNumber;
  final String? recipientName;
  final String? description;
  final String? provider; // For bill/airtime payments
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? failureReason;

  const Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.amount,
    this.currency = 'GHS',
    this.recipientMobileNumber,
    this.recipientName,
    this.description,
    this.provider,
    required this.createdAt,
    this.completedAt,
    this.failureReason,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        status,
        amount,
        currency,
        recipientMobileNumber,
        recipientName,
        description,
        provider,
        createdAt,
        completedAt,
        failureReason,
      ];
}
