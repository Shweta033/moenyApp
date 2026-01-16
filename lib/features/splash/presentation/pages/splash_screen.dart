import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/splash_bloc.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../wallet/presentation/pages/wallet_dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<SplashBloc>()..add(const StartSplashEvent()),
      child: BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => WalletDashboardScreen(userId: state.user.id),
            ),
          );
        } else if (state is SplashUnauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen(),
              ),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.asset(
              'assets/splashimage.png',
              scale: 3,
            ),
          ),
        ),
      ),
    );
  }
}
