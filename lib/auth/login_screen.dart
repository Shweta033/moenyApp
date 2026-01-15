import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generated/assets.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final mobileCtrl = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(
        // backgroundColor: Colors.blue.shade700,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          title: Image.asset(Assets.assetsSplashimage, scale: 4),
          centerTitle: true,
        ),

        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpSentState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OtpScreen()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                /// Heading
                const Text(
                  "Welcome 👋",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),
                const Text(
                  "Enter your mobile number to continue",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),

                const SizedBox(height: 40),

                /// Mobile Number Field
                TextFormField(
                  controller: mobileCtrl,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: "Mobile Number",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => OtpScreen()),
                      );
                    },
                    child: const Text(
                      "Send OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
