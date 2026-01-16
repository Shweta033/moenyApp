import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/airtime_purchase.dart';
import '../repositories/airtime_repository.dart';

class GetAirtimePurchaseHistory implements UseCase<List<AirtimePurchase>, GetAirtimePurchaseHistoryParams> {
  final AirtimeRepository repository;

  GetAirtimePurchaseHistory(this.repository);

  @override
  Future<Either<Failure, List<AirtimePurchase>>> call(GetAirtimePurchaseHistoryParams params) async {
    return await repository.getAirtimePurchaseHistory(params.userId);
  }
}

class GetAirtimePurchaseHistoryParams {
  final String userId;

  GetAirtimePurchaseHistoryParams({required this.userId});
}
