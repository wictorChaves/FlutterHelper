import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  AuthService._constructor();

  static final AuthService _instance = AuthService._constructor();

  factory AuthService() {
    return _instance;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<AuthResult> Create(String email, String password) =>
      auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<AuthResult> Login(String email, String password) =>
      auth.signInWithEmailAndPassword(email: email, password: password);

  Future<FirebaseUser> GetCurrentUser() {
    return auth.currentUser();
  }

  Future<bool> IsLogged() async => (await GetCurrentUser()) != null;

  Future<void> Logout() => auth.signOut();

}