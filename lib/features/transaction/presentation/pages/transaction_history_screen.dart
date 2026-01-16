import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../../domain/entities/transaction.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final String userId;

  const TransactionHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionHistoryLoaded) {
            if (state.transactions.isEmpty) {
              return const Center(
                child: Text('No transactions yet'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final transaction = state.transactions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(
                      _getTransactionIcon(transaction.type),
                      color: _getTransactionColor(transaction.status),
                    ),
                    title: Text(_getTransactionTypeLabel(transaction.type)),
                    subtitle: Text(
                      '${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
                    ),
                    trailing: Text(
                      _getStatusLabel(transaction.status),
                      style: TextStyle(
                        color: _getTransactionColor(transaction.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TransactionError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TransactionBloc>().add(
                            GetTransactionHistoryEvent(userId: userId),
                          );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  IconData _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.send:
        return Icons.send;
      case TransactionType.receive:
        return Icons.call_received;
      case TransactionType.request:
        return Icons.request_quote;
      case TransactionType.billPayment:
        return Icons.receipt;
      case TransactionType.airtimePurchase:
        return Icons.phone_android;
    }
  }

  String _getTransactionTypeLabel(TransactionType type) {
    switch (type) {
      case TransactionType.send:
        return 'Send Money';
      case TransactionType.receive:
        return 'Received Money';
      case TransactionType.request:
        return 'Request Money';
      case TransactionType.billPayment:
        return 'Bill Payment';
      case TransactionType.airtimePurchase:
        return 'Airtime Purchase';
    }
  }

  String _getStatusLabel(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.success:
        return 'Success';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getTransactionColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return Colors.green;
      case TransactionStatus.failed:
        return Colors.red;
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.cancelled:
        return Colors.grey;
    }
  }
}
