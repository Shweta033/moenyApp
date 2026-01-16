import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/link_wallet.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/domain/usecases/send_otp.dart';
import '../../features/auth/domain/usecases/submit_profile.dart';
import '../../features/auth/domain/usecases/verify_otp.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../features/wallet/data/datasources/wallet_local_data_source.dart';
import '../../features/wallet/data/datasources/wallet_remote_data_source.dart';
import '../../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';
import '../../features/wallet/domain/usecases/get_user_wallets.dart';
import '../../features/wallet/domain/usecases/get_wallet.dart';
import '../../features/wallet/domain/usecases/refresh_wallet_balance.dart';
import '../../features/wallet/presentation/bloc/wallet_bloc.dart';
import '../../features/transaction/data/datasources/transaction_local_data_source.dart';
import '../../features/transaction/data/datasources/transaction_remote_data_source.dart';
import '../../features/transaction/data/repositories/transaction_repository_impl.dart';
import '../../features/transaction/domain/repositories/transaction_repository.dart';
import '../../features/transaction/domain/usecases/get_transaction_by_id.dart';
import '../../features/transaction/domain/usecases/get_transaction_history.dart';
import '../../features/transaction/domain/usecases/request_money.dart';
import '../../features/transaction/domain/usecases/send_money.dart';
import '../../features/transaction/presentation/bloc/transaction_bloc.dart';
import '../../features/bill_payment/data/datasources/bill_payment_local_data_source.dart';
import '../../features/bill_payment/data/datasources/bill_payment_remote_data_source.dart';
import '../../features/bill_payment/data/repositories/bill_payment_repository_impl.dart';
import '../../features/bill_payment/domain/repositories/bill_payment_repository.dart';
import '../../features/bill_payment/domain/usecases/get_bill_payment_history.dart';
import '../../features/bill_payment/domain/usecases/pay_bill.dart';
import '../../features/bill_payment/presentation/bloc/bill_payment_bloc.dart';
import '../../features/airtime/data/datasources/airtime_local_data_source.dart';
import '../../features/airtime/data/datasources/airtime_remote_data_source.dart';
import '../../features/airtime/data/repositories/airtime_repository_impl.dart';
import '../../features/airtime/domain/repositories/airtime_repository.dart';
import '../../features/airtime/domain/usecases/get_airtime_purchase_history.dart';
import '../../features/airtime/domain/usecases/purchase_airtime.dart';
import '../../features/airtime/presentation/bloc/airtime_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      sendOTP: sl(),
      verifyOTP: sl(),
      submitProfile: sl(),
      getCurrentUser: sl(),
      logout: sl(),
    ),
  );

  sl.registerFactory(
    () => SplashBloc(getCurrentUser: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SendOTP(sl()));
  sl.registerLazySingleton(() => VerifyOTP(sl()));
  sl.registerLazySingleton(() => SubmitProfile(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => LinkWallet(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  //! Features - Wallet
  // Bloc
  sl.registerFactory(
    () => WalletBloc(
      getWallet: sl(),
      getUserWallets: sl(),
      refreshWalletBalance: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetWallet(sl()));
  sl.registerLazySingleton(() => GetUserWallets(sl()));
  sl.registerLazySingleton(() => RefreshWalletBalance(sl()));

  // Repository
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<WalletLocalDataSource>(
    () => WalletLocalDataSourceImpl(),
  );

  //! Features - Transaction
  // Bloc
  sl.registerFactory(
    () => TransactionBloc(
      sendMoney: sl(),
      requestMoney: sl(),
      getTransactionHistory: sl(),
      getTransactionById: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SendMoney(sl()));
  sl.registerLazySingleton(() => RequestMoney(sl()));
  sl.registerLazySingleton(() => GetTransactionHistory(sl()));
  sl.registerLazySingleton(() => GetTransactionById(sl()));

  // Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(),
  );

  //! Features - Bill Payment
  // Bloc
  sl.registerFactory(
    () => BillPaymentBloc(
      payBill: sl(),
      getBillPaymentHistory: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => PayBill(sl()));
  sl.registerLazySingleton(() => GetBillPaymentHistory(sl()));

  // Repository
  sl.registerLazySingleton<BillPaymentRepository>(
    () => BillPaymentRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<BillPaymentRemoteDataSource>(
    () => BillPaymentRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<BillPaymentLocalDataSource>(
    () => BillPaymentLocalDataSourceImpl(),
  );

  //! Features - Airtime
  // Bloc
  sl.registerFactory(
    () => AirtimeBloc(
      purchaseAirtime: sl(),
      getAirtimePurchaseHistory: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => PurchaseAirtime(sl()));
  sl.registerLazySingleton(() => GetAirtimePurchaseHistory(sl()));

  // Repository
  sl.registerLazySingleton<AirtimeRepository>(
    () => AirtimeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AirtimeRemoteDataSource>(
    () => AirtimeRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<AirtimeLocalDataSource>(
    () => AirtimeLocalDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
