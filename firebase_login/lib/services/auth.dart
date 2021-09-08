import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInAnonim() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user!;
  }

  Future<User> createUserWithEmailAndPassword(String email, String pass) async {
    final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
    return userCredentials.user!;
  }

  Future<User> signInWithEmailAndPassword(String email, String pass) async {
    final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
    return userCredentials.user!;
  }

  Future<void> signOut() async {
    final userCredential = await _firebaseAuth.signOut();
    return userCredential;
  }
}
