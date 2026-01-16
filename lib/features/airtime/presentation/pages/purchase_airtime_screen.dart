import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/airtime_bloc.dart';
import '../../domain/entities/airtime_purchase.dart';

class PurchaseAirtimeScreen extends StatefulWidget {
  final String userId;

  const PurchaseAirtimeScreen({super.key, required this.userId});

  @override
  State<PurchaseAirtimeScreen> createState() => _PurchaseAirtimeScreenState();
}

class _PurchaseAirtimeScreenState extends State<PurchaseAirtimeScreen> {
  final _mobileController = TextEditingController();
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  
  AirtimeProvider _selectedProvider = AirtimeProvider.mtn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Airtime'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: BlocListener<AirtimeBloc, AirtimeState>(
        listener: (context, state) {
          if (state is AirtimePurchaseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Airtime purchased successfully!')),
            );
            Navigator.pop(context);
          } else if (state is AirtimeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<AirtimeProvider>(
                value: _selectedProvider,
                decoration: const InputDecoration(labelText: 'Provider'),
                items: AirtimeProvider.values.map((provider) {
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
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
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
              BlocBuilder<AirtimeBloc, AirtimeState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is AirtimeLoading
                          ? null
                          : () {
                              if (_mobileController.text.isNotEmpty &&
                                  _amountController.text.isNotEmpty &&
                                  _pinController.text.length == 4) {
                                context.read<AirtimeBloc>().add(
                                      PurchaseAirtimeEvent(
                                        userId: widget.userId,
                                        provider: _selectedProvider,
                                        mobileNumber: _mobileController.text,
                                        amount: double.parse(_amountController.text),
                                        pin: _pinController.text,
                                      ),
                                    );
                              }
                            },
                      child: state is AirtimeLoading
                          ? const CircularProgressIndicator()
                          : const Text('Purchase Airtime'),
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

  String _getProviderLabel(AirtimeProvider provider) {
    switch (provider) {
      case AirtimeProvider.mtn:
        return 'MTN';
      case AirtimeProvider.vodafone:
        return 'Vodafone';
      case AirtimeProvider.airtelTigo:
        return 'AirtelTigo';
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
