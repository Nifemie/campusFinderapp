import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../login_page.dart';

class SignUpController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required BuildContext context,
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // Check for duplicate email or phone
      final existingUser = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      final existingPhone = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phone)
          .get();

      if (existingUser.docs.isNotEmpty || existingPhone.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email or phone already exists.')),
        );
        return;
      }

      // Save new user to Firestore
      await _firestore.collection('users').add({
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'password': password, // You should hash this in production
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      // Go to LoginPage after delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
}
