import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut() async => await _firebaseAuth.signOut();

  Future<String> signUpAnonymously() async {
    var data = await _firebaseAuth.signInAnonymously();
    return data.user!.uid;
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String? get currentUserId => _firebaseAuth.currentUser?.uid;
}
