import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_step1.dart';

class SignUpStep2 extends StatefulWidget {
  const SignUpStep2({super.key});

  @override
  State<SignUpStep2> createState() => _SignUpStep2State();
}

class _SignUpStep2State extends State<SignUpStep2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _matricController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Step 2: Additional Info"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(_departmentController, 'Department'),
                const SizedBox(height: 16),
                _buildTextField(_levelController, 'Level of Study (e.g. 200)'),
                const SizedBox(height: 16),
                _buildTextField(_matricController, 'Matric Number'),
                const SizedBox(height: 16),
                _buildTextField(_phoneController, 'Phone Number', inputType: TextInputType.phone),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Account created successfully!")),
                      );

                      // Wait 2 seconds, then navigate to LoginPage using MaterialPageRoute
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                              (route) => false,
                        );
                      });
                    }
                  },


                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Complete Sign Up"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType inputType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}
