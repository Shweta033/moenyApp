import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  
  final dobCtrl = TextEditingController(text: "23-Jul-2022");
  final nameCtrl = TextEditingController();
  final idCtrl = TextEditingController();

  final ValueNotifier<String> gender = ValueNotifier("Male");
  final ValueNotifier<String> idType = ValueNotifier("Driver's License");

  ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        title: Image.asset('assets/splashimage.png', scale: 4),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ProfileCompletedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile completed successfully")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
            );
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
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
                const Text(
                  "Complete Your Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _label("Full Name"),
                TextFormField(
                  controller: nameCtrl,
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 16),
                _label("Date of Birth"),
                TextFormField(
                  controller: dobCtrl,
                  readOnly: true,
                  decoration: _inputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 16),
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
                _label("ID Card Type"),
                ValueListenableBuilder(
                  valueListenable: idType,
                  builder: (_, value, __) {
                    return DropdownButtonFormField(
                      value: value,
                      items: const [
                        DropdownMenuItem(
                          value: "Driver's License",
                          child: Text("Driver's License"),
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
                _label("ID Card Number"),
                TextFormField(
                  controller: idCtrl,
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 30),
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
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (nameCtrl.text.isNotEmpty &&
                                idCtrl.text.isNotEmpty) {
                              context.read<AuthBloc>().add(
                                    SubmitProfileEvent(
                                      userId: userId,
                                      name: nameCtrl.text,
                                      idNumber: idCtrl.text,
                                    ),
                                  );
                            }
                          },
                    child: state is AuthLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Complete Profile",
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

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );

  InputDecoration _inputDecoration({Widget? suffixIcon}) => InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      );
}
