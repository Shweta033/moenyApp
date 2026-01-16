import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/airtime_purchase.dart';

abstract class AirtimeRepository {
  Future<Either<Failure, AirtimePurchase>> purchaseAirtime({
    required String userId,
    required AirtimeProvider provider,
    required String mobileNumber,
    required double amount,
    required String pin,
  });
  Future<Either<Failure, List<AirtimePurchase>>> getAirtimePurchaseHistory(String userId);
}
