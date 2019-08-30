import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_messenger/models/User.dart';
import 'package:flutter_messenger/providers/BaseProviders.dart';
import 'package:flutter_messenger/providers/UserDataProvider.dart';

class UserDataRepository {
  BaseUserDataProvider userDataProvider = UserDataProvider();

  Future<User> saveDetailsFromGoogleAuth(FirebaseUser user) =>
      userDataProvider.saveDetailsFromGoogleAuth(user);

  Future<User> saveProfileDetails(
          String uid, String profileImageUrl, int age, String username) =>
      userDataProvider.saveProfileDetails(uid, profileImageUrl, age, username);

  Future<bool> isProfileComplete(String uid) =>
      userDataProvider.isProfileComplete(uid);
}
