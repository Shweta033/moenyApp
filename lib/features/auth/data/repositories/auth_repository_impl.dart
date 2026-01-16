import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> sendOTP(String mobileNumber) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.sendOTP(mobileNumber);
        return const Right(null);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOTP(String mobileNumber, String otp) async {
    try {
      if (await networkInfo.isConnected) {
        final userModel = await remoteDataSource.verifyOTP(mobileNumber, otp);
        await localDataSource.cacheUser(userModel);
        return Right(userModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> submitProfile({
    required String userId,
    required String name,
    required String idNumber,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final userModel = await remoteDataSource.submitProfile(
          userId: userId,
          name: name,
          idNumber: idNumber,
        );
        await localDataSource.cacheUser(userModel);
        return Right(userModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> linkWallet({
    required String userId,
    required String provider,
    required String mobileNumber,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final userModel = await remoteDataSource.linkWallet(
          userId: userId,
          provider: provider,
          mobileNumber: mobileNumber,
        );
        await localDataSource.cacheUser(userModel);
        return Right(userModel);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      // Try local first
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser);
      }

      // Then try remote
      if (await networkInfo.isConnected) {
        final user = await remoteDataSource.getCurrentUser();
        if (user != null) {
          await localDataSource.cacheUser(user);
        }
        return Right(user);
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearCache();
      await localDataSource.clearToken();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
