import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilemoney/auth/bloc/auth_bloc.dart';
import 'package:mobilemoney/auth/bloc/auth_state.dart';
import 'package:mobilemoney/auth/login_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../generated/assets.dart';
import 'bloc/auth_event.dart';
import 'profile_screen.dart';

class OtpScreen extends StatelessWidget {
  final otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),

        /// 🔙 Back Button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          },
        ),

        title: Image.asset(Assets.assetsSplashimage, scale: 4),
        centerTitle: true,
      ),

      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpVerifiedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.email_outlined,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Verify your email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Kindly input the code was sent to your email address for confirmation",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "ZetLabs@gmail.com",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Icon(Icons.edit, size: 18, color: Colors.orange),
                      SizedBox(width: 4),
                      Text("Edit", style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: otpCtrl,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    activeColor: Colors.black,
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                  onChanged: (value) {},
                ),

                const SizedBox(height: 20),
                const Text(
                  "Didn’t receive any code?",
                  style: TextStyle(color: Colors.orange),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Resend OTP in 0:32s",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 80),
                // const Spacer(),
                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfileScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
