import 'package:firebase_auth/firebase_auth.dart';
import 'package:gorouterdeeplink/domain/repo/authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  @override
  Future<UserCredential> emailSignUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signIn(String email, String password) async {
    print(email);
    print(password);
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
