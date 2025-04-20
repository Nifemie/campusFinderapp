import 'package:flutter/material.dart';
import 'signup_step2.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({super.key});

  @override
  State<SignUpStep1> createState() => _SignUpStep1State();
}

class _SignUpStep1State extends State<SignUpStep1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Set background to white
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(_nameController, 'Full Name'),
                    const SizedBox(height: 16),
                    _buildTextField(_emailController, 'Email Address', inputType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    _buildTextField(_passwordController, 'Password', isPassword: true),
                    const SizedBox(height: 16),
                    _buildTextField(_confirmPasswordController, 'Confirm Password', isPassword: true),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // ✅ Navigate to Step 2
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpStep2(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Next Step'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool isPassword = false, TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter $hintText';
        if (hintText == 'Confirm Password' && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}
