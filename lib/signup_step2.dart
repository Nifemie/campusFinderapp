import 'package:flutter/material.dart';
import 'login_page.dart';
import '../services/sign_logic.dart'; // Make sure this path is correct

class SignUpStep2 extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const SignUpStep2({
    super.key,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  State<SignUpStep2> createState() => _SignUpStep2State();
}

class _SignUpStep2State extends State<SignUpStep2> {
  final _formKey = GlobalKey<FormState>();
  final _signUpController = SignUpController();

  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _matricController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Step 2: Additional Info")),
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
                _buildTextField(
                  _phoneController,
                  'Phone Number',
                  inputType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _signUpController.registerUser(
                        context: context,
                        fullName: widget.fullName,
                        email: widget.email,
                        phone: _phoneController.text.trim(),
                        password: widget.password,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Complete Sign Up"),
                ),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) =>
      value == null || value.isEmpty ? 'Please enter $labelText' : null,
    );
  }
}
