import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/airtime_purchase.dart';
import '../repositories/airtime_repository.dart';

class PurchaseAirtime implements UseCase<AirtimePurchase, PurchaseAirtimeParams> {
  final AirtimeRepository repository;

  PurchaseAirtime(this.repository);

  @override
  Future<Either<Failure, AirtimePurchase>> call(PurchaseAirtimeParams params) async {
    return await repository.purchaseAirtime(
      userId: params.userId,
      provider: params.provider,
      mobileNumber: params.mobileNumber,
      amount: params.amount,
      pin: params.pin,
    );
  }
}

class PurchaseAirtimeParams {
  final String userId;
  final AirtimeProvider provider;
  final String mobileNumber;
  final double amount;
  final String pin;

  PurchaseAirtimeParams({
    required this.userId,
    required this.provider,
    required this.mobileNumber,
    required this.amount,
    required this.pin,
  });
}
