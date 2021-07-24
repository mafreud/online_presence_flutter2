class FirestorePath {
  /// users
  static const String userDomain = 'users';

  static String userPath(String userId) => '$userDomain/$userId';
}
