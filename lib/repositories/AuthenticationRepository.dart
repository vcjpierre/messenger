import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_messenger/providers/AuthenticationProvider.dart';
import 'package:flutter_messenger/providers/BaseProviders.dart';

class AuthenticationRepository {
  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<FirebaseUser> signInWithGoogle() =>
      authenticationProvider.signInWithGoogle();

  Future<void> signOutUser() => authenticationProvider.signOutUser();

  Future<FirebaseUser> getCurrentUser() =>
      authenticationProvider.getCurrentUser();

  Future<bool> isLoggedIn() => authenticationProvider.isLoggedIn();
}
