// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilemoney/auth/login_screen.dart';
import 'package:mobilemoney/generated/assets.dart';

import 'bloc/splah_state.dart';
import 'bloc/splash_bloc.dart';
import 'bloc/splash_event.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(StartSplashEvent()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            } else if (state is SplashUnauthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            }
          },
          child: Center(child: Image.asset(Assets.assetsSplashimage, scale: 3)),
        ),
      ),
    );
  }
}
