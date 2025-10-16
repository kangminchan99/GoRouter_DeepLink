import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gorouterdeeplink/data/repo/authentication_repo_impl.dart';

abstract class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  Future<UserCredential> emailSignUp(String email, String password);

  Future<void> signOut();

  Future<void> signIn(String email, String password);
}

final authRepo = Provider((ref) => AuthenticationRepoImpl());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
