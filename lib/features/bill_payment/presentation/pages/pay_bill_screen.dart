import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bill_payment_bloc.dart';
import '../../domain/entities/bill_payment.dart';

class PayBillScreen extends StatefulWidget {
  final String userId;

  const PayBillScreen({super.key, required this.userId});

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  
  BillType _selectedBillType = BillType.electricity;
  BillProvider _selectedProvider = BillProvider.ecg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bill'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: BlocListener<BillPaymentBloc, BillPaymentState>(
        listener: (context, state) {
          if (state is BillPaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bill paid successfully!')),
            );
            Navigator.pop(context);
          } else if (state is BillPaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<BillType>(
                value: _selectedBillType,
                decoration: const InputDecoration(labelText: 'Bill Type'),
                items: BillType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getBillTypeLabel(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedBillType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<BillProvider>(
                value: _selectedProvider,
                decoration: const InputDecoration(labelText: 'Provider'),
                items: BillProvider.values.map((provider) {
                  return DropdownMenuItem(
                    value: provider,
                    child: Text(_getProviderLabel(provider)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedProvider = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _accountController,
                decoration: const InputDecoration(
                  labelText: 'Account Number',
                  prefixIcon: Icon(Icons.account_circle),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount (GHS)',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _pinController,
                decoration: const InputDecoration(
                  labelText: 'PIN',
                  prefixIcon: Icon(Icons.lock),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
              ),
              const SizedBox(height: 24),
              BlocBuilder<BillPaymentBloc, BillPaymentState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is BillPaymentLoading
                          ? null
                          : () {
                              if (_accountController.text.isNotEmpty &&
                                  _amountController.text.isNotEmpty &&
                                  _pinController.text.length == 4) {
                                context.read<BillPaymentBloc>().add(
                                      PayBillEvent(
                                        userId: widget.userId,
                                        billType: _selectedBillType,
                                        provider: _selectedProvider,
                                        accountNumber: _accountController.text,
                                        amount: double.parse(_amountController.text),
                                        pin: _pinController.text,
                                      ),
                                    );
                              }
                            },
                      child: state is BillPaymentLoading
                          ? const CircularProgressIndicator()
                          : const Text('Pay Bill'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getBillTypeLabel(BillType type) {
    switch (type) {
      case BillType.electricity:
        return 'Electricity';
      case BillType.water:
        return 'Water';
      case BillType.telecom:
        return 'Telecom';
    }
  }

  String _getProviderLabel(BillProvider provider) {
    switch (provider) {
      case BillProvider.ecg:
        return 'ECG';
      case BillProvider.gwc:
        return 'Ghana Water Company';
      case BillProvider.mtn:
        return 'MTN';
      case BillProvider.vodafone:
        return 'Vodafone';
      case BillProvider.airtelTigo:
        return 'AirtelTigo';
    }
  }

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
