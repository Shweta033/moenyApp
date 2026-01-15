import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilemoney/auth/otp_screen.dart';

import '../generated/assets.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final dobCtrl = TextEditingController(text: "23-Jul-2022");
  final idCtrl = TextEditingController(text: "TTD23658694TY83");

  final ValueNotifier<String> gender = ValueNotifier("Male");
  final ValueNotifier<String> idType = ValueNotifier("Driver’s License");
  final ValueNotifier<String> verificationMode = ValueNotifier("Selfie taken");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 🔝 AppBar
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
              MaterialPageRoute(builder: (_) => OtpScreen()),
            );
          },
        ),

        title: Image.asset(Assets.assetsSplashimage, scale: 4),
        centerTitle: true,
      ),

      /// 🔁 BLoC
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ProfileCompletedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Verification Completed")),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                /// Title
                const Text(
                  "Identity Verification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                /// Date of Birth
                _label("Date of Birth"),
                TextFormField(
                  controller: dobCtrl,
                  readOnly: true,
                  decoration: _inputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),

                const SizedBox(height: 16),

                /// Gender
                _label("Gender"),
                ValueListenableBuilder(
                  valueListenable: gender,
                  builder: (_, value, __) {
                    return DropdownButtonFormField(
                      value: value,
                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text("Female"),
                        ),
                      ],
                      onChanged: (v) => gender.value = v!,
                      decoration: _inputDecoration(),
                    );
                  },
                ),

                const SizedBox(height: 16),

                /// ID Card Type
                _label("ID Card Type"),
                ValueListenableBuilder(
                  valueListenable: idType,
                  builder: (_, value, __) {
                    return DropdownButtonFormField(
                      value: value,
                      items: const [
                        DropdownMenuItem(
                          value: "Driver’s License",
                          child: Text("Driver’s License"),
                        ),
                        DropdownMenuItem(
                          value: "Passport",
                          child: Text("Passport"),
                        ),
                      ],
                      onChanged: (v) => idType.value = v!,
                      decoration: _inputDecoration(),
                    );
                  },
                ),

                const SizedBox(height: 16),

                /// ID Number
                _label("ID Card Number"),
                TextFormField(
                  controller: idCtrl,
                  decoration: _inputDecoration(),
                ),

                const SizedBox(height: 24),

                /// Verification Mode
                const Text(
                  "Select your preferred verification mode",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                _radioTile("Selfie taken", verificationMode, Colors.blue),
                _radioTile("Use biometrics", verificationMode, Colors.grey),
                _radioTile("Send OTP via SMS", verificationMode, Colors.grey),

                const SizedBox(height: 30),

                /// Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Complete Verification",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ---------- UI Helpers ----------

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.grey)),
  );

  InputDecoration _inputDecoration({Widget? suffixIcon}) => InputDecoration(
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  );

  Widget _radioTile(
    String title,
    ValueNotifier<String> notifier,
    Color activeColor,
  ) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (_, value, __) {
        final selected = value == title;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: selected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: RadioListTile(
            value: title,
            groupValue: value,
            onChanged: (v) => notifier.value = v!,
            title: Text(
              title,
              style: TextStyle(color: selected ? Colors.white : Colors.black),
            ),
            activeColor: Colors.white,
          ),
        );
      },
    );
  }
}
