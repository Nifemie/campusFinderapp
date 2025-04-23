import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerWithEmailAndPhone({
    required String email,
    required String password,
    required String phone,
    required String matricNumber,
    required String department,
    required String level,
  }) async {
    try {
      // Check if email or phone exists
      final existingUsers = await _firestore.collection('users').get();
      for (var doc in existingUsers.docs) {
        final data = doc.data();
        if (data['email'] == email || data['phone'] == phone) {
          return null; // Email or phone exists
        }
      }

      // Register user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'phone': phone,
          'matricNumber': matricNumber,
          'department': department,
          'level': level,
        });
      }

      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
