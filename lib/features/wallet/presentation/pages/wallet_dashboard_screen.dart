import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/wallet_bloc.dart';

class WalletDashboardScreen extends StatelessWidget {
  final String userId;

  const WalletDashboardScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallets'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WalletsLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.wallets.length,
              itemBuilder: (context, index) {
                final wallet = state.wallets[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade700,
                      child: Text(
                        wallet.provider[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(wallet.provider),
                    subtitle: Text('${wallet.currency} ${wallet.balance.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        context.read<WalletBloc>().add(
                              RefreshWalletBalanceEvent(walletId: wallet.id),
                            );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is WalletError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WalletBloc>().add(
                            GetUserWalletsEvent(userId: userId),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add wallet screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
