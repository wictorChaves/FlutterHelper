import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<AuthResult> Create(String email, String password) =>
      auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<AuthResult> Login(String email, String password) =>
      auth.signInWithEmailAndPassword(email: email, password: password);

  Future<FirebaseUser> GetCurrentUser() {
    return auth.currentUser();
  }

  Future<bool> IsLogged() async => (await auth.currentUser()) != null;

  Future<FirebaseUser> Logout() => auth.signOut();
}